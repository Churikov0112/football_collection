part of 'football_players_packs_screen.dart';

class FootballPlayersPacksScreenPresenter extends StatefulWidget {
  static FootballPlayersPacksScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayersPacksScreenPresenterState>()!;
  }

  final Widget child;
  final FootballPlayersPacksScreenArgs args;

  const FootballPlayersPacksScreenPresenter({required this.args, required this.child, super.key});

  @override
  State<FootballPlayersPacksScreenPresenter> createState() => FootballPlayersPacksScreenPresenterState();
}

class FootballPlayersPacksScreenPresenterState extends State<FootballPlayersPacksScreenPresenter>
    with TickerProviderStateMixin, FootballPlayersPacksYandexAdsRewardedMixin {
  late AnimationController _hidePacksAnimationController;
  late Animation<double> _hidePacksAnimation;

  O3DController? o3dController;
  late CarouselSliderController packsCarouselController;

  // нужно для показа 3d модели пака
  final BehaviorSubject<int> selectedPackIndexSubject = BehaviorSubject.seeded(0);
  Stream<int> get selectedPackIndexStream$ => selectedPackIndexSubject.stream;

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

  Set<String> _newCardIdsForOpenedPack = <String>{};

  @override
  void initState() {
    super.initState();
    _hidePacksAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _hidePacksAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _hidePacksAnimationController, curve: Curves.linear));
    context.read<FootballPlayersPacksBloc>().add(
      FootballPlayersPacksEventGet(country: widget.args.country, confederation: widget.args.confederation),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // loadBannerAd();
      createRewardedAdLoader();

      try {
        await FirebaseAnalytics.instance.logEvent(
          name: "open_packs_screen",
          parameters: {
            if (widget.args.country != null) "country": widget.args.country!.name,
            if (widget.args.confederation != null) "confederation": widget.args.confederation!.name,
          },
        );
      } catch (e) {
        LogService.error(e.toString(), e);
      }
    });
  }

  Future<void> setSelectedPackIndex(int index) async {
    o3dController = O3DController();
    selectedPackIndexSubject.add(index);
    _show3dObjectSubject.add(false);
    await Future.delayed(const Duration(milliseconds: 100)); // TODO это безопасно?
    _show3dObjectSubject.add(true);
  }

  Future<void> openPack(PackModel pack) async {
    final participantCountry = getIt.get<LeaderboardCountryBloc>().state.countryName;
    final alreadySavedCards = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
    _newCardIdsForOpenedPack = (pack.cards ?? const <CardModel>[])
        .where((card) => !alreadySavedCards.contains(card.cardId))
        .map((card) => card.cardId)
        .toSet();
    final newCardsFromPack = _newCardIdsForOpenedPack.length;

    try {
      final packTitle = pack.title.toLowerCase().replaceAll(" ", "_");
      await FirebaseAnalytics.instance.logEvent(
        name: "pack_opened",
        parameters: {
          if (widget.args.country != null) "country": widget.args.country!.name,
          if (widget.args.confederation != null) "confederation": widget.args.confederation!.name,
          "pack_index": selectedPackIndexSubject.value,
          "pack_title": packTitle,
        },
      );
    } catch (e) {
      LogService.error(e.toString(), e);
    }

    if (participantCountry != null) {
      try {
        unawaited(
          getIt.get<FirestoreService>().submitPackOpened(
            country: participantCountry,
            cardsReceivedFromPack: newCardsFromPack,
          ),
        );
      } catch (e) {
        LogService.error(e.toString(), e);
      }
    }

    final settings = getIt.get<SettingsBloc>().state;
    try {
      _isHidePacksAnimationPlayingSubject.add(true);
      _hidePacksAnimationController.forward().whenCompleteOrCancel(() async {
        o3dController?.play(repetitions: 1);
        await Future.delayed(const Duration(milliseconds: 200));
        for (var i = 0; i < 27; i++) {
          if (settings.enableVibration) unawaited(HapticFeedback.lightImpact());
          await Future.delayed(const Duration(milliseconds: 100));
        }
        await Future.delayed(const Duration(milliseconds: 700));
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
        builder: (context) => NotEnoghtMoneyBottomSheet(pack: pack, presenter: this),
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
    final balanceState = await getIt.get<BalanceBloc>().stream.firstWhere(
      (state) => state is BalanceStateReady || state is BalanceStateFailed,
    );
    if (balanceState is BalanceStateFailed) {
      ToastService.showErrorToast(title: balanceState.message);
    } else if (balanceState is BalanceStateReady) {
      await openPack(pack);
    }
  }

  void getNewPacks() {
    context.read<FootballPlayersPacksBloc>().add(
      FootballPlayersPacksEventGet(country: widget.args.country, confederation: widget.args.confederation),
    );
    _isHidePacksAnimationPlayingSubject.add(false);
    _isUnpackingAnimationPlayingSubject.add(false);
  }

  void savePlayer(FootballPlayerCardModel player) {
    getIt.get<SavedCardsBloc>().add(SavedCardsEventAdd(cardId: player.cardId));
  }

  Future<void> showReceivedCards(List<CardModel> cards, String packName) async {
    final players = cards.whereType<FootballPlayerCardModel>().toList();
    _isUnpackingAnimationPlayingSubject.add(false);
    await context.push(
      RoutePaths.footballPlayersPackResults,
      extra: FootballPlayersPackResultsScreenArgs(
        cards: players,
        newCardIds: _newCardIdsForOpenedPack,
        packName: packName,
      ),
    );
    getNewPacks();
  }

  @override
  void dispose() {
    _hidePacksAnimationController.dispose();
    o3dController = null;
    _isHidePacksAnimationPlayingSubject.close();
    _isUnpackingAnimationPlayingSubject.close();
    _isWaitingConfirmSubject.close();
    _show3dObjectSubject.close();
    rewardedAd?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FootballPlayersPacksBloc, FootballPlayersPacksState>(
      listener: (context, footballPlayersPacksState) {
        if (footballPlayersPacksState is FootballPlayersPacksStateLoadSucceeded) {
          // final packs = stickerpacksState.packs ?? [];
          setSelectedPackIndex(selectedPackIndexSubject.value);
          packsCarouselController = CarouselSliderController();
        }
      },
      child: widget.child,
    );
  }
}
