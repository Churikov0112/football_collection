part of 'sticker_pack_screen.dart';

class StickerpackScreenPresenter extends StatefulWidget {
  static StickerpackScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<StickerpackScreenPresenterState>()!;
  }

  final Widget child;
  final StickerpackScreenArgs args;

  const StickerpackScreenPresenter({
    required this.args,
    required this.child,
    super.key,
  });

  @override
  State<StickerpackScreenPresenter> createState() => StickerpackScreenPresenterState();
}

class StickerpackScreenPresenterState extends State<StickerpackScreenPresenter> with TickerProviderStateMixin {
  late Gallery3DController gallery3dController;

  late AnimationController _selectPackAnimationController;
  late Animation<double> _selectPackAnimation;

  GifController? _gifController;

  final BehaviorSubject<bool> _isPackSelectingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isPackSelectingStream$ => _isPackSelectingSubject.stream;

  final BehaviorSubject<bool> _isUnpackingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isUnpackingStream$ => _isUnpackingSubject.stream;

  final BehaviorSubject<bool> _isPackOpenedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isPackOpenedStream$ => _isPackOpenedSubject.stream;

  PackModel? openedPack;

  @override
  void initState() {
    super.initState();
    context
        .read<StickerpacksBloc>()
        .add(StickerpacksEventGet(country: widget.args.country, confederation: widget.args.confederation));

    _selectPackAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Уменьшено
    );
    _selectPackAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _selectPackAnimationController, curve: Curves.linear), // Упрощено
    );
  }

  Future<void> selectPack(PackModel pack) async {
    openedPack = pack;
    _gifController = GifController(vsync: this); // Ленивая инициализация
    // unawaited(HapticFeedback.lightImpact());
    await Future.delayed(const Duration(milliseconds: 1000));
    _isPackSelectingSubject.add(true);
    _selectPackAnimationController.forward();
  }

  void unpackCards() async {
    _gifController?.forward();
    // unawaited(HapticFeedback.vibrate());
    await Future.delayed(const Duration(milliseconds: 3800));
    _gifController?.stop();
    _isUnpackingSubject.add(true);
    _selectPackAnimationController.reverse();
  }

  void getNewPacks() {
    openedPack = null;
    context.read<StickerpacksBloc>().add(StickerpacksEventGet());
    _isPackOpenedSubject.add(false);
    _isPackSelectingSubject.add(false);
    _isUnpackingSubject.add(false);
  }

  void savePlayer(PlayerModel player) {
    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAdd(playerId: player.id));
  }

  @override
  void dispose() {
    _selectPackAnimationController.dispose();
    _gifController?.dispose();
    _isPackSelectingSubject.close();
    _isUnpackingSubject.close();
    _isPackOpenedSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StickerpacksBloc, StickerpacksState>(
      listener: (context, stickerpacksState) {
        if (stickerpacksState is StickerpacksStateLoadSucceeded) {
          final packs = stickerpacksState.packs ?? [];
          gallery3dController = Gallery3DController(
            itemCount: packs.length,
            autoLoop: false,
          );
        }
      },
      child: widget.child,
    );
  }
}
