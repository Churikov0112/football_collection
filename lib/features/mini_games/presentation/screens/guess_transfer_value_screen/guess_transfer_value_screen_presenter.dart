part of 'guess_transfer_value_screen.dart';

const _kDefaultRewardValue = 1;

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

class GuessTransferValueScreenPresenterState extends State<GuessTransferValueScreenPresenter>
    with GuessTransferValueYandexAdsBannerMixin {
  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  final random = Random();
  int winstrick = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadRandomPlayer();
      loadBannerAd();
    });
  }

  void loadRandomPlayer() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context
          .read<RandomFootballPlayersBloc>()
          .add(RandomFootballPlayersEventGet(count: 1, minPrimeTransferValue: 25000000));
    }
  }

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
