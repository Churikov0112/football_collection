part of 'guess_stadium_by_country_and_seats_screen.dart';

const _kDefaultRewardValue = 1;

class GuessStadiumByCountryAndSeatsScreenPresenter extends StatefulWidget {
  static GuessStadiumByCountryAndSeatsScreenPresenterState of(
    BuildContext context,
  ) {
    return context
        .findAncestorStateOfType<
          GuessStadiumByCountryAndSeatsScreenPresenterState
        >()!;
  }

  final Widget child;

  const GuessStadiumByCountryAndSeatsScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<GuessStadiumByCountryAndSeatsScreenPresenter> createState() =>
      GuessStadiumByCountryAndSeatsScreenPresenterState();
}

class GuessStadiumByCountryAndSeatsScreenPresenterState
    extends State<GuessStadiumByCountryAndSeatsScreenPresenter>
    with GuessStadiumByCountryAndSeatsYandexAdsBannerMixin {
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
      loadRandomClubs();
    });
  }

  void loadRandomClubs() {
    if (mounted) {
      _selectedOptionSubject.add(null);
      context.read<RandomFootballClubsBloc>().add(
        RandomFootballClubsEventGet(
          count: 20,
          withStadiumName: true,
          withStadiumSeats: true,
          withLeague: true,
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
    loadRandomClubs();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
