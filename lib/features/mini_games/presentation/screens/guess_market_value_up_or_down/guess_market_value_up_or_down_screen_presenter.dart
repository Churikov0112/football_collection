part of 'guess_market_value_up_or_down_screen.dart';

const _kDefaultRewardValue = 1;

class GuessMarketValueUpOrDownScreenPresenter extends StatefulWidget {
  static GuessMarketValueUpOrDownScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessMarketValueUpOrDownScreenPresenterState>()!;
  }

  final Widget child;

  const GuessMarketValueUpOrDownScreenPresenter({required this.child, super.key});

  @override
  State<GuessMarketValueUpOrDownScreenPresenter> createState() => GuessMarketValueUpOrDownScreenPresenterState();
}

class GuessMarketValueUpOrDownScreenPresenterState extends State<GuessMarketValueUpOrDownScreenPresenter>
    with GuessTransferValueYandexAdsBannerMixin {
  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;

  final random = Random();
  int winstrick = 0;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadRandomValue();
      loadBannerAd();
    });
  }

  void loadRandomValue() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context.read<RandomMarketValueBloc>().add(
        RandomMarketValueEventGet(minItems: 10, minPrimeTransferValue: 25000000),
      );
    }
  }

  Future<void> showResult({required String selectedAnswer, required String rightAnswer}) async {
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
    loadRandomValue();
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
