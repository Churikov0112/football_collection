part of 'club_foundation_date_screen.dart';

const _kDefaultRewardValue = 1;

class ClubFoundationDateScreenPresenter extends StatefulWidget {
  static ClubFoundationDateScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<ClubFoundationDateScreenPresenterState>()!;
  }

  final Widget child;

  const ClubFoundationDateScreenPresenter({required this.child, super.key});

  @override
  State<ClubFoundationDateScreenPresenter> createState() => ClubFoundationDateScreenPresenterState();
}

class ClubFoundationDateScreenPresenterState extends State<ClubFoundationDateScreenPresenter>
    with ClubFoundationDateYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final BehaviorSubject<DateTime?> _selectedOptionSubject = BehaviorSubject.seeded(null);
  Stream<DateTime?> get selectedOptionStream$ => _selectedOptionSubject.stream;

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
      context.read<RandomFootballClubsBloc>().add(RandomFootballClubsEventGet(count: 1, withFoundedOn: true));
    }
  }

  Future<void> showResult({required DateTime selectedAnswer, required DateTime rightAnswer}) async {
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
