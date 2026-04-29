part of 'guess_flag_by_country_screen.dart';

const _kDefaultRewardValue = 1;
const _kOptionsCount = 4;
const _kQuestionRepeatWindow = 10;
const _kColorSimilarityJitterPool = 8;
const _kDistractorsCount = _kOptionsCount - 1;

class GuessFlagByCountryScreenPresenter extends StatefulWidget {
  static GuessFlagByCountryScreenPresenterState of(BuildContext context) {
    return context
        .findAncestorStateOfType<GuessFlagByCountryScreenPresenterState>()!;
  }

  final Widget child;

  const GuessFlagByCountryScreenPresenter({required this.child, super.key});

  @override
  State<GuessFlagByCountryScreenPresenter> createState() =>
      GuessFlagByCountryScreenPresenterState();
}

class GuessFlagByCountryScreenPresenterState
    extends State<GuessFlagByCountryScreenPresenter>
    with GuessCountryByFlagYandexAdsBannerMixin {
  // int winstrick = 0;
  final Random random = Random();
  final CommonFootballRepository _repository = getIt
      .get<CommonFootballRepository>();
  final FlagColorSimilarityService _flagColorSimilarityService =
      FlagColorSimilarityService();

  List<FootballNationalTeamModel> _allTeams = [];
  Map<String, FootballNationalTeamModel> _teamById = {};
  Map<String, Map<int, double>> _flagColorProfiles = {};
  final List<String> _recentCorrectAnswerIds = [];
  bool _isPreparingGame = true;
  double _prepareProgress = 0;

  final BehaviorSubject<String?> _selectedOptionSubject =
      BehaviorSubject.seeded(null);
  Stream<String?> get selectedOptionStream$ => _selectedOptionSubject.stream;
  final BehaviorSubject<_GuessFlagByCountryRound?> _roundSubject =
      BehaviorSubject.seeded(null);
  Stream<_GuessFlagByCountryRound?> get roundStream$ => _roundSubject.stream;

  bool get isPreparingGame => _isPreparingGame;
  int get prepareProgressPercent => (_prepareProgress * 100).round();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadBannerAd();
      _prepareGame();
    });
  }

  Future<void> _prepareGame() async {
    try {
      final teams = await _repository.teamsGet();
      final profiles = await _flagColorSimilarityService
          .buildProfilesFromPrecomputed(
            teams: teams,
            precomputedColors: teamFlagColors,
            onProgress: (current, total) {
              if (!mounted || total == 0) {
                return;
              }
              setState(() {
                _prepareProgress = current / total;
              });
            },
          );

      final teamsWithFlags = teams
          .where((team) => profiles.containsKey(team.id))
          .toList(growable: false);
      final gameTeams = teamsWithFlags.length >= _kOptionsCount
          ? teamsWithFlags
          : teams;

      if (!mounted) {
        return;
      }
      setState(() {
        _allTeams = gameTeams;
        _teamById = {for (final team in gameTeams) team.id: team};
        _flagColorProfiles = profiles;
        _isPreparingGame = false;
        _prepareProgress = 1;
      });

      _loadNextRound();
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isPreparingGame = false;
      });
    }
  }

  void _loadNextRound() {
    if (_allTeams.length < _kOptionsCount) {
      return;
    }

    final correctAnswer = _pickNextCorrectAnswer();
    final options = <FootballNationalTeamModel>[correctAnswer];
    final similarByColorIds = _flagColorSimilarityService
        .findMostSimilarByColorTeamIds(
          targetTeamId: correctAnswer.id,
          profiles: _flagColorProfiles,
          limit: _allTeams.length,
        );
    final colorJitterPool = similarByColorIds
        .take(_kColorSimilarityJitterPool)
        .toList(growable: false);
    final shuffledSimilarTeamIds = List<String>.from(colorJitterPool)
      ..shuffle(random);

    _addOptionsFromIds(
      options: options,
      candidateIds: shuffledSimilarTeamIds,
      maxToAdd: _kDistractorsCount,
    );
    _addOptionsFromIds(
      options: options,
      candidateIds: similarByColorIds
          .skip(_kColorSimilarityJitterPool)
          .toList(growable: false),
      maxToAdd: _kDistractorsCount,
    );

    while (options.length < _kOptionsCount) {
      final randomTeam = _allTeams[random.nextInt(_allTeams.length)];
      if (options.contains(randomTeam)) {
        continue;
      }
      options.add(randomTeam);
    }

    options.shuffle(random);
    _rememberCorrectAnswer(correctAnswer.id);
    _selectedOptionSubject.add(null);
    _roundSubject.add(
      _GuessFlagByCountryRound(correctAnswer: correctAnswer, options: options),
    );
  }

  FootballNationalTeamModel _pickNextCorrectAnswer() {
    if (_allTeams.length <= 1) {
      return _allTeams.first;
    }

    if (_recentCorrectAnswerIds.isEmpty) {
      return _allTeams[random.nextInt(_allTeams.length)];
    }

    final availableTeams = _allTeams
        .where((team) => !_recentCorrectAnswerIds.contains(team.id))
        .toList(growable: false);
    final pool = availableTeams.isNotEmpty ? availableTeams : _allTeams;
    return pool[random.nextInt(pool.length)];
  }

  void _addOptionsFromIds({
    required List<FootballNationalTeamModel> options,
    required List<String> candidateIds,
    int? maxToAdd,
  }) {
    if (options.length >= _kOptionsCount) return;

    var addedCount = 0;
    for (final teamId in candidateIds) {
      if (options.length >= _kOptionsCount) return;
      final team = _teamById[teamId];
      if (team == null || options.contains(team)) continue;
      options.add(team);
      addedCount++;
      if (maxToAdd != null && addedCount >= maxToAdd) return;
      if (options.length == _kOptionsCount) return;
    }
  }

  void _rememberCorrectAnswer(String teamId) {
    _recentCorrectAnswerIds.add(teamId);

    final maxRecentAnswers = min(_kQuestionRepeatWindow, _allTeams.length - 1);
    while (_recentCorrectAnswerIds.length > maxRecentAnswers) {
      _recentCorrectAnswerIds.removeAt(0);
    }
  }

  Future<void> showResult({
    required FootballNationalTeamModel selectedAnswer,
    required FootballNationalTeamModel rightAnswer,
  }) async {
    _selectedOptionSubject.add(selectedAnswer.id);
    if (selectedAnswer.id == rightAnswer.id) {
      getIt.get<BalanceBloc>().add(
        BalanceEventIncrease(amount: _kDefaultRewardValue),
      );
      ToastService.showToast(
        title: AppGlossary.correct.translate(),
        subtitle:
            "${AppGlossary.rewarded.translate()} $_kDefaultRewardValue 🏆",
        seconds: 2,
      );
      // winstrick++;
    } else {
      ToastService.showErrorToast(
        title: AppGlossary.incorrect.translate(),
        subtitle: ":(",
        seconds: 2,
      );
      // winstrick = 0;
    }
    await Future.delayed(const Duration(seconds: 2));
    _loadNextRound();
  }

  @override
  void dispose() {
    final shouldDestroyBanner =
        isBannerAlreadyCreatedSubject.valueOrNull == true;
    _selectedOptionSubject.close();
    _roundSubject.close();
    isBannerAlreadyCreatedSubject.close();
    if (shouldDestroyBanner) {
      banner.destroy();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _GuessFlagByCountryRound {
  const _GuessFlagByCountryRound({
    required this.correctAnswer,
    required this.options,
  });

  final FootballNationalTeamModel correctAnswer;
  final List<FootballNationalTeamModel> options;
}
