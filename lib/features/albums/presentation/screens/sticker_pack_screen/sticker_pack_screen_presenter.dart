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
  late AnimationController _hidePacksAnimationController;
  late Animation<double> _hidePacksAnimation;

  O3DController? o3dController;
  late PageController packsPageController;

  final BehaviorSubject<int> _selectedPackIndexSubject = BehaviorSubject.seeded(0);
  Stream<int> get selectedPackIndexStream$ => _selectedPackIndexSubject.stream;

  final BehaviorSubject<bool> _show3dObjectSubject = BehaviorSubject.seeded(false);
  Stream<bool> get show3dObjectStream$ => _show3dObjectSubject.stream;

  final BehaviorSubject<bool> _isWaitingConfirmSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isWaitingConfirmStream$ => _isWaitingConfirmSubject.stream;

  final BehaviorSubject<bool> _isHidePacksAnimationPlayingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isHidePacksAnimationPlayingStream$ => _isHidePacksAnimationPlayingSubject.stream;

  final BehaviorSubject<bool> _isUnpackingAnimationPlayingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isUnpackingAnimationPlayingStream$ => _isUnpackingAnimationPlayingSubject.stream;

  @override
  void initState() {
    super.initState();
    context
        .read<StickerpacksBloc>()
        .add(StickerpacksEventGet(country: widget.args.country, confederation: widget.args.confederation));
    _hidePacksAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Уменьшено
    );
    _hidePacksAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hidePacksAnimationController, curve: Curves.linear), // Упрощено
    );
  }

  Future<void> setSelectedPackIndex(int index) async {
    o3dController = O3DController();
    _selectedPackIndexSubject.add(index);
    _show3dObjectSubject.add(false);
    await Future.delayed(const Duration(milliseconds: 100));
    _show3dObjectSubject.add(true);
    // pack = selectedPack;
  }

  Future<void> openPack() async {
    try {
      _isHidePacksAnimationPlayingSubject.add(true); // show 3d model
      _hidePacksAnimationController.forward().whenCompleteOrCancel(() async {
        o3dController?.play(repetitions: 1);
        await Future.delayed(const Duration(milliseconds: 3500));
        o3dController?.pause();
        _isUnpackingAnimationPlayingSubject.add(true);
        _hidePacksAnimationController.reverse();
      });
    } catch (e) {
      LogService.log(e.toString());
    }
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
              SizedBox(height: mq.padding.bottom + 20)
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
      await openPack();
    }
  }

  void getNewPacks() {
    // pack = null;
    context
        .read<StickerpacksBloc>()
        .add(StickerpacksEventGet(country: widget.args.country, confederation: widget.args.confederation));
    _isHidePacksAnimationPlayingSubject.add(false);
    _isUnpackingAnimationPlayingSubject.add(false);
  }

  void savePlayer(PlayerModel player) {
    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventAdd(playerId: player.id));
  }

  @override
  void dispose() {
    _hidePacksAnimationController.dispose();
    o3dController = null;
    _isHidePacksAnimationPlayingSubject.close();
    _isUnpackingAnimationPlayingSubject.close();
    _isWaitingConfirmSubject.close();
    _show3dObjectSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StickerpacksBloc, StickerpacksState>(
      listener: (context, stickerpacksState) {
        if (stickerpacksState is StickerpacksStateLoadSucceeded) {
          // final packs = stickerpacksState.packs ?? [];
          setSelectedPackIndex(_selectedPackIndexSubject.value);
          packsPageController = PageController(viewportFraction: 0.6);
        }
      },
      child: widget.child,
    );
  }
}
