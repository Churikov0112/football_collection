part of 'open_pack_screen.dart';

class OpenPackScreenPresenter extends StatefulWidget {
  static OpenPackScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<OpenPackScreenPresenterState>()!;
  }

  final Widget child;
  final OpenPackScreenArgs args;

  const OpenPackScreenPresenter({
    required this.args,
    required this.child,
    super.key,
  });

  @override
  State<OpenPackScreenPresenter> createState() => OpenPackScreenPresenterState();
}

class OpenPackScreenPresenterState extends State<OpenPackScreenPresenter> with TickerProviderStateMixin {
  late AnimationController _hidePacksAnimationController;
  late Animation<double> _hidePacksAnimation;

  O3DController? o3dController;
  late PageController packsPageController;

// нужно для показа 3d модели пака
  final BehaviorSubject<int> _selectedPackIndexSubject = BehaviorSubject.seeded(0);
  Stream<int> get selectedPackIndexStream$ => _selectedPackIndexSubject.stream;

// нужно для показа 3d модели пака
  final BehaviorSubject<bool> _show3dObjectSubject = BehaviorSubject.seeded(false);
  Stream<bool> get show3dObjectStream$ => _show3dObjectSubject.stream;

// нужно для предотвращения повторного нажатия на пак
  final BehaviorSubject<bool> _isWaitingConfirmSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isWaitingConfirmStream$ => _isWaitingConfirmSubject.stream;

// нужно для предотвращения повторного нажатия на пак
  final BehaviorSubject<bool> _isHidePacksAnimationPlayingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isHidePacksAnimationPlayingStream$ => _isHidePacksAnimationPlayingSubject.stream;

// нужно для показа карточек игроков
  final BehaviorSubject<bool> _isUnpackingAnimationPlayingSubject = BehaviorSubject.seeded(false);
  Stream<bool> get isUnpackingAnimationPlayingStream$ => _isUnpackingAnimationPlayingSubject.stream;

  @override
  void initState() {
    super.initState();
    _hidePacksAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _hidePacksAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hidePacksAnimationController, curve: Curves.linear),
    );
    context
        .read<StickerpacksBloc>()
        .add(StickerpacksEventGet(country: widget.args.country, confederation: widget.args.confederation));
  }

  Future<void> setSelectedPackIndex(int index) async {
    o3dController = O3DController();
    _selectedPackIndexSubject.add(index);
    _show3dObjectSubject.add(false);
    await Future.delayed(const Duration(milliseconds: 100)); // TODO это безопасно?
    _show3dObjectSubject.add(true);
  }

  Future<void> openPack() async {
    try {
      _isHidePacksAnimationPlayingSubject.add(true);
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
    final isEnoughtMoney = (getIt.get<BalanceBloc>().state.balance ?? 0) >= pack.price;
    if (!isEnoughtMoney) {
      await showModalBottomSheet<bool>(
        context: context,
        builder: (context) => NotEnoghtMoneyBottomSheet(pack: pack),
      );
      _isWaitingConfirmSubject.add(false);
      return;
    }
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) => ConfirmBuyPackBottomSheet(pack: pack),
    );
    _isWaitingConfirmSubject.add(false);
    if (confirmed != true) return;
    getIt.get<BalanceBloc>().add(BalanceEventDecrease(amount: pack.price));
    final balanceState = await getIt
        .get<BalanceBloc>()
        .stream
        .firstWhere((state) => state is BalanceStateReady || state is BalanceStateFailed);
    if (balanceState is BalanceStateFailed) {
      ToastService.showErrorToast(title: balanceState.message);
    } else if (balanceState is BalanceStateReady) {
      await openPack();
    }
  }

  void getNewPacks() {
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
          packsPageController = PageController(viewportFraction: 0.6, initialPage: _selectedPackIndexSubject.value);
        }
      },
      child: widget.child,
    );
  }
}
