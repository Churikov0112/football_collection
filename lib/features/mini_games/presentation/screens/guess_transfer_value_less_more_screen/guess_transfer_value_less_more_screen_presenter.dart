part of 'guess_transfer_value_less_more_screen.dart';

class GuessTransferValueLessMoreScreenPresenter extends StatefulWidget {
  static GuessTransferValueLessMoreScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessTransferValueLessMoreScreenPresenterState>()!;
  }

  final Widget child;

  const GuessTransferValueLessMoreScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessTransferValueLessMoreScreenPresenter> createState() => GuessTransferValueLessMoreScreenPresenterState();
}

class GuessTransferValueLessMoreScreenPresenterState extends State<GuessTransferValueLessMoreScreenPresenter> {
  final random = Random();

  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 2, hasTransferValue: true));
    });
  }

  void loadRandomPlayers() {
    _selectedOptionSubject.add(null);
    context.read<RandomPlayersBloc>().add(RandomPlayersEventGet(count: 2, hasTransferValue: true));
  }

  Future<void> showResult({
    required String selectedAnswer,
    required String rightAnswer,
  }) async {
    _selectedOptionSubject.add(selectedAnswer);
    if (selectedAnswer == rightAnswer) {
      getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 5));
      ToastService.showToast(title: "Правильно!", subtitle: "Начислено 5 🏆", seconds: 2);
    } else {
      ToastService.showErrorToast(title: "Неправильно!", seconds: 2);
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
