part of 'guess_height_screen.dart';

const _kDefaultRewardValue = 1;

class GuessHeightScreenPresenter extends StatefulWidget {
  static GuessHeightScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessHeightScreenPresenterState>()!;
  }

  final Widget child;

  const GuessHeightScreenPresenter({required this.child, super.key});

  @override
  State<GuessHeightScreenPresenter> createState() =>
      GuessHeightScreenPresenterState();
}

class GuessHeightScreenPresenterState extends State<GuessHeightScreenPresenter>
    with GuessHeightYandexAdsBannerMixin {
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
        RandomFootballPlayersEventGet(count: 4, withHeight: true),
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
