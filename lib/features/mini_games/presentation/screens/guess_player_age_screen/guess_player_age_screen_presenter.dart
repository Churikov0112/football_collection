part of 'guess_player_age_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPlayerAgeScreenPresenter extends StatefulWidget {
  static GuessPlayerAgeScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<GuessPlayerAgeScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPlayerAgeScreenPresenter({required this.child, super.key});

  @override
  State<GuessPlayerAgeScreenPresenter> createState() =>
      GuessPlayerAgeScreenPresenterState();
}

class GuessPlayerAgeScreenPresenterState
    extends State<GuessPlayerAgeScreenPresenter>
    with GuessPlayerAgeYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<int?> _selectedOptionSubject = BehaviorSubject.seeded(
    null,
  );
  Stream<int?> get selectedOptionStream$ => _selectedOptionSubject.stream;

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
      context.read<RandomFootballPlayersBloc>().add(
        RandomFootballPlayersEventGet(count: 4, withAge: true),
      );
    }
  }

  Future<void> showResult({
    required int selectedAnswer,
    required int rightAnswer,
  }) async {
    _selectedOptionSubject.add(selectedAnswer);
    if (selectedAnswer == rightAnswer) {
      getIt.get<BalanceBloc>().add(
        BalanceEventIncrease(amount: _kDefaultRewardValue + winstrick),
      );
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
