part of 'guess_player_join_date_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPlayerJoinDateScreenPresenter extends StatefulWidget {
  static GuessPlayerJoinDateScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<GuessPlayerJoinDateScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPlayerJoinDateScreenPresenter({required this.child, super.key});

  @override
  State<GuessPlayerJoinDateScreenPresenter> createState() =>
      GuessPlayerJoinDateScreenPresenterState();
}

class GuessPlayerJoinDateScreenPresenterState
    extends State<GuessPlayerJoinDateScreenPresenter>
    with GuessPlayerJoinDateYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<DateTime?> _selectedOptionSubject =
      BehaviorSubject.seeded(null);
  Stream<DateTime?> get selectedOptionStream$ => _selectedOptionSubject.stream;

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
        RandomFootballPlayersEventGet(count: 4, withJoinedClubOn: true),
      );
    }
  }

  Future<void> showResult({
    required DateTime selectedAnswer,
    required DateTime rightAnswer,
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
