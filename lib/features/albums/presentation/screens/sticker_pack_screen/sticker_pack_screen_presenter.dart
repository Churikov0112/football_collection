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

class StickerpackScreenPresenterState extends State<StickerpackScreenPresenter> with _YandexAdsMixin {
  final BehaviorSubject<bool> _isPackOpenedSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isPackOpenedStream$ => _isPackOpenedSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<StickerpackBloc>().add(StickerpackEventGet());
    });
  }

  void openPack() {
    _isPackOpenedSubject.add(true);
  }

  void getNewPack() {
    context.read<StickerpackBloc>().add(StickerpackEventGet());
    _isPackOpenedSubject.add(false);
  }

  void savePlayer(PlayerModel player) {
    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAdd(player: player));
  }

  @override
  void dispose() {
    _isPackOpenedSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
