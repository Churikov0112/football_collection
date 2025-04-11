part of 'guess_who_is_more_expensive_screen.dart';

const _kDefaultRewardValue = 1;

class GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter extends StatefulWidget {
  static GuessWhichFootballPlayerIsMoreExpensiveScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessWhichFootballPlayerIsMoreExpensiveScreenPresenterState>()!;
  }

  final Widget child;

  const GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter> createState() =>
      GuessWhichFootballPlayerIsMoreExpensiveScreenPresenterState();
}

class GuessWhichFootballPlayerIsMoreExpensiveScreenPresenterState
    extends State<GuessWhichFootballPlayerIsMoreExpensiveScreenPresenter>
    with GuessWhichFootballPlayerIsMoreExpensiveYandexAdsBannerMixin {
  final random = Random();

  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  int winstrick = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadRandomPlayers();
      loadBannerAd();
    });
  }

  void loadRandomPlayers() {
    _selectedOptionSubject.add(null);
    context
        .read<RandomFootballPlayersBloc>()
        .add(RandomFootballPlayersEventGet(count: 2, minPrimeTransferValue: 25000000));
  }

  // Future<void> showResult({
  //   required String selectedAnswer,
  //   required String rightAnswer,
  // }) async {
  //   _selectedOptionSubject.add(selectedAnswer);
  //   if (selectedAnswer == rightAnswer) {
  //     getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 5));
  //     ToastService.showToast(title: "Правильно!", subtitle: "Начислено 5 🏆", seconds: 2);
  //   } else {
  //     ToastService.showErrorToast(title: "Неправильно!", seconds: 2);
  //   }
  //   await Future.delayed(const Duration(seconds: 2));
  //   loadRandomPlayers();
  // }

  Future<void> showResult({
    required String selectedAnswer,
    required String rightAnswer,
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
  void dispose() {
    _selectedOptionSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
