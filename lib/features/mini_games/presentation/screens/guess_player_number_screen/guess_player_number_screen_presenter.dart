part of 'guess_player_number_screen.dart';

const _kDefaultRewardValue = 1;

class GuessPlayerNumberScreenPresenter extends StatefulWidget {
  static GuessPlayerNumberScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<GuessPlayerNumberScreenPresenterState>()!;
  }

  final Widget child;

  const GuessPlayerNumberScreenPresenter({required this.child, super.key});

  @override
  State<GuessPlayerNumberScreenPresenter> createState() => GuessPlayerNumberScreenPresenterState();
}

class GuessPlayerNumberScreenPresenterState extends State<GuessPlayerNumberScreenPresenter>
    with GuessPlayerNumberYandexAdsBannerMixin {
  int winstrick = 0;
  final Random random = Random();

  final Map<String, List<String>> positionToCommonNumbers = {
    // Вратари
    'Goalkeeper': ['1', '13', '23', '25', '33'],

    // Центральные защитники
    'Centre-Back': ['4', '5', '6', '15', '24', '26'],

    // Левые защитники
    'Left-Back': ['3', '12', '17', '20', '22'],

    // Правые защитники
    'Right-Back': ['2', '12', '17', '22', '25'],

    // Опорные полузащитники
    'Defensive Midfield': ['6', '8', '14', '16', '24'],

    // Центральные полузащитники
    'Central Midfield': ['8', '10', '14', '16', '18', '21'],

    // Атакующие полузащитники
    'Attacking Midfield': ['7', '8', '10', '11', '19', '20'],

    // Левые вингеры
    'Left Winger': ['7', '11', '17', '19', '21', '22'],

    // Правые вингеры
    'Right Winger': ['7', '11', '22', '19', '21'],

    // Левые полузащитники
    'Left Midfield': ['7', '11', '17', '19', '21'],

    // Правые полузащитники
    'Right Midfield': ['7', '11', '22', '19', '21'],

    // Центральные нападающие
    'Centre-Forward': ['9', '10', '11', '14', '18', '19'],

    // Вторые нападающие
    'Second Striker': ['9', '10', '11', '14', '18', '19'],
  };

  final BehaviorSubject<String?> _selectedOptionSubject = BehaviorSubject.seeded(null);
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
      context.read<RandomFootballPlayersBloc>().add(RandomFootballPlayersEventGet(count: 4, withTeamShirtNumber: true));
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
    loadRandomPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
