part of 'guess_national_team_screen.dart';

const _kDefaultRewardValue = 1;

class GuessNationalTeamScreenPresenter extends StatefulWidget {
  static GuessNationalTeamScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessNationalTeamScreenPresenterState>()!;
  }

  final Widget child;

  const GuessNationalTeamScreenPresenter({required this.child, super.key});

  @override
  State<GuessNationalTeamScreenPresenter> createState() => GuessNationalTeamScreenPresenterState();
}

class GuessNationalTeamScreenPresenterState extends State<GuessNationalTeamScreenPresenter>
    with GuessPlayerCountryYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<FootballNationalTeamModel?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<FootballNationalTeamModel?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      loadRandomPlayer();
    });
  }

  void loadRandomPlayer() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context.read<RandomFootballPlayersBloc>().add(RandomFootballPlayersEventGet(count: 1));
    }
  }

  Future<void> showResult({
    required FootballNationalTeamModel selectedAnswer,
    required FootballNationalTeamModel rightAnswer,
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
      ToastService.showErrorToast(title: AppGlossary.incorrect.translate(), subtitle: ":(", seconds: 2);
      winstrick = 0;
    }
    await Future.delayed(const Duration(seconds: 2));
    loadRandomPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
