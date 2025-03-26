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

  final BehaviorSubject<bool> _isWaitingConfirmSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isWaitingConfirmStream$ => _isWaitingConfirmSubject.stream;

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

  Future<void> getPack(PackModel pack) async {
    openedPack = pack;
    _gifController = GifController(vsync: this); // Ленивая инициализация
    // unawaited(HapticFeedback.lightImpact());
    await Future.delayed(const Duration(milliseconds: 1000));
    _isPackSelectingSubject.add(true);
    _selectPackAnimationController.forward();
  }

  Future<void> requestBuyPackConfirm(PackModel pack) async {
    _isWaitingConfirmSubject.add(true);
    // TODO add not enought balance bs
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        final mq = MediaQuery.of(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text("Confirm to buy pack for ${pack.price} 🏆"),
              const SizedBox(height: 20),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.pop(false);
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context.pop(true);
                      },
                      child: Text("Confirm"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.padding.bottom)
            ],
          ),
        );
      },
    );
    _isWaitingConfirmSubject.add(false);
    if (confirmed != true) return;
    // todo confirm bs
    getIt.get<BalanceBloc>().add(BalanceEventDecrease(amount: pack.price));
    final balanceState = await getIt
        .get<BalanceBloc>()
        .stream
        .firstWhere((state) => state is BalanceStateReady || state is BalanceStateFailed);
    if (balanceState is BalanceStateFailed) {
      ToastService.showErrorToast(title: balanceState.message);
    } else if (balanceState is BalanceStateReady) {
      ToastService.showToast(title: "Transaction completed");
      await getPack(pack);
    }
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
    context
        .read<StickerpacksBloc>()
        .add(StickerpacksEventGet(country: widget.args.country, confederation: widget.args.confederation));
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
    _isWaitingConfirmSubject.close();
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
