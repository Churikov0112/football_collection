part of 'guess_player_club_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPlayerClubScreenPresenter extends StatefulWidget {
  static GuessPlayerClubScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<GuessPlayerClubScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPlayerClubScreenPresenter({required this.child, super.key});

  @override
  State<GuessPlayerClubScreenPresenter> createState() =>
      GuessPlayerClubScreenPresenterState();
}

class GuessPlayerClubScreenPresenterState
    extends State<GuessPlayerClubScreenPresenter>
    with GuessPlayerClubYandexAdsBannerMixin {
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
          withClubName: true,
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
