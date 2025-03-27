part of 'guess_transfer_value_screen.dart';

class GuessTransferValueScreenPresenter extends StatefulWidget {
  static GuessTransferValueScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessTransferValueScreenPresenterState>()!;
  }

  final Widget child;

  const GuessTransferValueScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessTransferValueScreenPresenter> createState() => GuessTransferValueScreenPresenterState();
}

class GuessTransferValueScreenPresenterState extends State<GuessTransferValueScreenPresenter> {
  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  final random = Random();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadRandomPlayer();
    });
  }

  void loadRandomPlayer() {
    _selectedOptionSubject.add(null);
    context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 1, hasTransferValue: true));
  }

  Future<void> showResult({
    required String selectedAnswer,
    required String rightAnswer,
  }) async {
    _selectedOptionSubject.add(selectedAnswer);
    if (selectedAnswer == rightAnswer) {
      getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 1));
      ToastService.showToast(title: "Правильно!", subtitle: "Начислено 1 🏆", seconds: 2);
    } else {
      ToastService.showErrorToast(title: "Неправильно!", seconds: 2);
    }
    await Future.delayed(const Duration(seconds: 2));
    loadRandomPlayer();
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
