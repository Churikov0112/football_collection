part of 'guess_position_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPositionScreenPresenter extends StatefulWidget {
  static GuessPositionScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<GuessPositionScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPositionScreenPresenter({required this.child, super.key});

  @override
  State<GuessPositionScreenPresenter> createState() =>
      GuessPositionScreenPresenterState();
}

class GuessPositionScreenPresenterState
    extends State<GuessPositionScreenPresenter>
    with GuessPositionYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<String?> _selectedOptionSubject =
      BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

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
        RandomFootballPlayersEventGet(
          count: 20,
          minPrimeTransferValue: 10000000,
          withPosition: true,
        ),
      );
    }
  }

  Future<void> showResult({
    required String selectedAnswer,
    required String rightAnswer,
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
