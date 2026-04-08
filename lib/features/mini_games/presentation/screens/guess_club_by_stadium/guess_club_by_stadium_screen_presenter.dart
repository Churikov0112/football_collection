part of 'guess_club_by_stadium_screen.dart';

const _kDefaultRewardValue = 1;

class GuessClubByStadiumScreenPresenter extends StatefulWidget {
  static GuessClubByStadiumScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessClubByStadiumScreenPresenterState>()!;
  }

  final Widget child;

  const GuessClubByStadiumScreenPresenter({required this.child, super.key});

  @override
  State<GuessClubByStadiumScreenPresenter> createState() => GuessClubByStadiumScreenPresenterState();
}

class GuessClubByStadiumScreenPresenterState extends State<GuessClubByStadiumScreenPresenter>
    with GuessClubByStadiumYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
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
      context.read<RandomFootballClubsBloc>().add(RandomFootballClubsEventGet(count: 4, withStadiumName: true));
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
    loadRandomClubs();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
