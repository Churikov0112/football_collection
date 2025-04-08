part of 'guess_who_is_more_valuable_screen.dart';

const _kDefaultRewardValue = 1;

class GuessWhoIsMoreValuableScreenPresenter extends StatefulWidget {
  static GuessWhoIsMoreValuableScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessWhoIsMoreValuableScreenPresenterState>()!;
  }

  final Widget child;

  const GuessWhoIsMoreValuableScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessWhoIsMoreValuableScreenPresenter> createState() => GuessWhoIsMoreValuableScreenPresenterState();
}

class GuessWhoIsMoreValuableScreenPresenterState extends State<GuessWhoIsMoreValuableScreenPresenter> {
  final random = Random();

  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  int winstrick = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadRandomPlayers();
    });
  }

  void loadRandomPlayers() {
    _selectedOptionSubject.add(null);
    context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 2, minPrimeTransferValue: 25000000));
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
