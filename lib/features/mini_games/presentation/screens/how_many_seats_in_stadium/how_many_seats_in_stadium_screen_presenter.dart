part of 'how_many_seats_in_stadium_screen.dart';

const _kDefaultRewardValue = 1;

class HowManySeatsInStadiumScreenPresenter extends StatefulWidget {
  static HowManySeatsInStadiumScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<HowManySeatsInStadiumScreenPresenterState>()!;
  }

  final Widget child;

  const HowManySeatsInStadiumScreenPresenter({required this.child, super.key});

  @override
  State<HowManySeatsInStadiumScreenPresenter> createState() =>
      HowManySeatsInStadiumScreenPresenterState();
}

class HowManySeatsInStadiumScreenPresenterState
    extends State<HowManySeatsInStadiumScreenPresenter>
    with HowManySeatsInStadiumYandexAdsBannerMixin {
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
      loadRandomClubs();
    });
  }

  void loadRandomClubs() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context.read<RandomFootballClubsBloc>().add(
        RandomFootballClubsEventGet(count: 20, withStadiumSeats: true),
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
    loadRandomClubs();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
