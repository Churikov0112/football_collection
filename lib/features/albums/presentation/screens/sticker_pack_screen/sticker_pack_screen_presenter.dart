part of 'sticker_pack_screen.dart';

class StickerpackScreenPresenter extends StatefulWidget {
  static StickerpackScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<StickerpackScreenPresenterState>()!;
  }

  final Widget child;
  final CountryModel? country;

  const StickerpackScreenPresenter({
    required this.country,
    required this.child,
    super.key,
  });

  @override
  State<StickerpackScreenPresenter> createState() => StickerpackScreenPresenterState();
}

class StickerpackScreenPresenterState extends State<StickerpackScreenPresenter> with TickerProviderStateMixin {
  Gallery3DController gallery3dController = Gallery3DController(itemCount: 4, autoLoop: false);

  late AnimationController _selectPackAnimationController;
  late Animation<double> _selectPackAnimation;

  late GifController gifController;

  final BehaviorSubject<bool> _isPackSelectingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isPackSelectingStream$ => _isPackSelectingSubject.stream;

  final BehaviorSubject<bool> _isUnpackingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isUnpackingStream$ => _isUnpackingSubject.stream;

  final BehaviorSubject<bool> _isPackOpenedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isPackOpenedStream$ => _isPackOpenedSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<StickerpackBloc>().add(StickerpackEventGet());

      _selectPackAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );
      _selectPackAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _selectPackAnimationController, curve: Curves.easeInOut),
      );

      // gifController = GifController(vsync: this);
    });
  }

  Future<void> selectPack() async {
    // if (gifController.) return; // Проверяем, не удален ли контроллер
    // gifController.stop();
    gifController = GifController(vsync: this);
    unawaited(HapticFeedback.lightImpact());
    // HapticFeedback.vibrate();
    await Future.delayed(const Duration(milliseconds: 1000));
    _isPackSelectingSubject.add(true);
    _selectPackAnimationController.forward();
  }

  void unpackCards() async {
    gifController.forward();
    unawaited(HapticFeedback.vibrate());
    await Future.delayed(const Duration(milliseconds: 3800));
    gifController.stop();
    _isUnpackingSubject.add(true);
    _selectPackAnimationController.reverse();
  }

  void getNewPack() {
    context.read<StickerpackBloc>().add(StickerpackEventGet());
    _isPackOpenedSubject.add(false);
    _isPackSelectingSubject.add(false);
    _isUnpackingSubject.add(false);
  }

  void savePlayer(PlayerModel player) {
    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAdd(player: player));
  }

  @override
  void dispose() {
    _selectPackAnimationController.dispose(); // Удаляем AnimationController
    _isPackOpenedSubject.close();
    _isPackSelectingSubject.close();
    _isUnpackingSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
