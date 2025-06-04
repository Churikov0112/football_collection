part of 'guess_player_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPlayerScreenPresenter extends StatefulWidget {
  static GuessPlayerScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessPlayerScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPlayerScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessPlayerScreenPresenter> createState() => GuessPlayerScreenPresenterState();
}

class GuessPlayerScreenPresenterState extends State<GuessPlayerScreenPresenter>
    with GuessPlayerCountryYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<FootballPlayerModel?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<FootballPlayerModel?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      loadRandomPlayers();
    });
  }

  void loadRandomPlayers() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context
          .read<RandomFootballPlayersBloc>()
          .add(RandomFootballPlayersEventGet(count: 4, minPrimeTransferValue: 10000000));
    }
  }

  Future<void> showResult({
    required FootballPlayerModel selectedAnswer,
    required FootballPlayerModel rightAnswer,
  }) async {
    _selectedOptionSubject.add(selectedAnswer);
    if (selectedAnswer == rightAnswer) {
      getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: _kDefaultRewardValue + winstrick));
      ToastService.showToast(
        title: AppGlossary.correct.translate(),
        subtitle:
            "${AppGlossary.rewarded.translate()} ${_kDefaultRewardValue + winstrick} 🏆, ${AppGlossary.winstrick.translate()} $winstrick",
        seconds: 2,
      );
      winstrick++;
    } else {
      ToastService.showErrorToast(
        title: AppGlossary.incorrect.translate(),
        subtitle: ":(",
        seconds: 2,
      );
      winstrick = 0;
    }
    await Future.delayed(const Duration(seconds: 2));
    loadRandomPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
