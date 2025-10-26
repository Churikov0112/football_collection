part of 'draft_screen.dart';

class DraftScreenPresenter extends StatefulWidget {
  static DraftScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<DraftScreenPresenterState>()!;
  }

  final Widget child;

  const DraftScreenPresenter({required this.child, super.key});

  @override
  State<DraftScreenPresenter> createState() => DraftScreenPresenterState();
}

class DraftScreenPresenterState extends State<DraftScreenPresenter> {
  final BehaviorSubject<FootballScheme> _schemeSubject = BehaviorSubject.seeded(FootballScheme.values.first);
  Stream<FootballScheme> get scheme$ => _schemeSubject.stream;

  late final BehaviorSubject<List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)>> _startingSquadSubject;
  Stream<List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)>> get startingSquad$ =>
      _startingSquadSubject.stream;

  final Map<FootballPlayerAbstractPosition, List<FootballPlayerCardModel>> _draftPlayers = {};

  final BehaviorSubject<int> _draftPageSubject = BehaviorSubject.seeded(1);
  Stream<int> get draftPage$ => _draftPageSubject.stream;

  final BehaviorSubject<(FootballPlayerPositionOnField, FootballPlayerGameModel?)?> _selectedPlayerSubject =
      BehaviorSubject.seeded(null);
  Stream<(FootballPlayerPositionOnField, FootballPlayerGameModel?)?> get selectedPlayer$ =>
      _selectedPlayerSubject.stream;

  final BehaviorSubject<List<(PositionConnectionRule, double)>> _connectionsChemistrySubject = BehaviorSubject.seeded(
    [],
  );
  Stream<List<(PositionConnectionRule, double)>> get connectionsChemistry$ => _connectionsChemistrySubject.stream;

  final BehaviorSubject<String?> _captainIdSubject = BehaviorSubject.seeded(null);
  Stream<String?> get captainId$ => _captainIdSubject.stream;

  @override
  void initState() {
    final scheme = _schemeSubject.value;
    final squad = squadFromScheme(scheme);
    _startingSquadSubject = BehaviorSubject.seeded(squad);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDraftPlayers();

      _startingSquadSubject.listen((ss) {
        _calcSquadChemistry();
      });
    });
  }

  void setScheme(FootballScheme scheme) {
    _schemeSubject.add(scheme);
    final squad = squadFromScheme(scheme);
    _startingSquadSubject.add(squad);
  }

  List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)> squadFromScheme(FootballScheme scheme) {
    final pofs = FootballSchemes.vertical[scheme] ?? [];
    final squad = <(FootballPlayerPositionOnField, FootballPlayerGameModel?)>[];
    for (final pof in pofs) {
      squad.add((pof, null));
    }
    return squad;
  }

  void nextPage() {
    if (_draftPageSubject.value == 3) {
      submitSquad();
    } else {
      _draftPageSubject.add(_draftPageSubject.value + 1);
    }
  }

  void previousPage() {
    _draftPageSubject.add(_draftPageSubject.value - 1);
  }

  void getDraftPlayers() {
    final allPlayers = getIt.get<AllFootballPlayersBloc>().state.allPlayers ?? [];
    final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? [];
    final savedPlayers = allPlayers.where((p) => savedCardsIds.contains(p.cardId)).toList();

    if (savedPlayers.isEmpty) {
      return;
    }

    final Random random = Random();

    final Map<FootballPlayerAbstractPosition, List<FootballPlayerCardModel>> newDraftPlayers = {};
    final Set<FootballPlayerCardModel> usedPlayers = {};

    for (final abstractPosition in FootballPlayerAbstractPosition.values) {
      // Фильтруем игроков по позиции (основная позиция должна совпадать)
      final positionPlayers = savedPlayers.where((player) {
        return player.position == abstractPosition;
      }).toList();

      // Если игроков нужной позиции мало, добавляем похожие позиции
      List<FootballPlayerCardModel> filteredPlayers = [];
      if (positionPlayers.length >= 5) {
        filteredPlayers = positionPlayers;
      } else {
        // Добавляем игроков основной позиции + ближайшие похожие позиции
        filteredPlayers = savedPlayers.where((player) {
          final weight = PositionWeights.getWeight(
            abstractPosition,
            FootballPlayerAbstractPosition.fromString(player.position),
          );
          return weight > 0.7; // Берем только достаточно близкие позиции
        }).toList();
      }

      // Сортируем по рейтингу (по убыванию)
      filteredPlayers.sort((a, b) {
        final ratingA = FootballPlayerStatsCalculator.calculateStats(a).rating;
        final ratingB = FootballPlayerStatsCalculator.calculateStats(b).rating;
        return ratingB.compareTo(ratingA);
      });

      List<FootballPlayerCardModel> availablePlayers = filteredPlayers
          .where((player) => !usedPlayers.contains(player))
          .toList();
      // Если доступных игроков мало, разрешаем повторное использование
      if (availablePlayers.length < 5) {
        availablePlayers = [...filteredPlayers];
      }

      // final List<FootballPlayerCardModel> availablePlayers = [...filteredPlayers];

      // Берем топ-25 кандидатов по рейтингу
      final topCandidates = availablePlayers.take(25).toList();
      List<FootballPlayerCardModel> selectedPlayers = [];

      if (topCandidates.length <= 5) {
        selectedPlayers = [...topCandidates];
      } else {
        // Случайный выбор из топ-25, но сохраняя приоритет высокого рейтинга
        // Даем больше шансов игрокам с высоким рейтингом
        final weightedCandidates = <FootballPlayerCardModel>[];
        for (int i = 0; i < topCandidates.length; i++) {
          // Игроки с более высоким рейтингом имеют больше "билетов" в лотерее
          final weight = (topCandidates.length - i) * 2; // Первые игроки имеют больший вес
          for (int j = 0; j < weight; j++) {
            weightedCandidates.add(topCandidates[i]);
          }
        }

        weightedCandidates.shuffle(random);

        final uniqueSelected = <FootballPlayerCardModel>{};
        for (final candidate in weightedCandidates) {
          if (uniqueSelected.length >= 5) {
            break;
          }
          uniqueSelected.add(candidate);
        }
        selectedPlayers = uniqueSelected.toList();
      }

      newDraftPlayers[abstractPosition] = selectedPlayers;
      usedPlayers.addAll(selectedPlayers);
    }

    _draftPlayers.clear();
    _draftPlayers.addAll(newDraftPlayers);
  }

  void selectPlayer(String? playerId) {
    if (_selectedPlayerSubject.value?.$2?.card.playerId == playerId) {
      _selectedPlayerSubject.add(null);
      return;
    }

    final player = _startingSquadSubject.value.firstWhereOrNull((p) => p.$2?.id == playerId);
    _selectedPlayerSubject.add(player);
  }

  void swapPlayersOnField(String? player1Id, String? player2Id) {
    if (player1Id == null || player2Id == null || player1Id == player2Id) {
      _selectedPlayerSubject.add(null);
      return;
    }

    final currentSquad = _startingSquadSubject.value;

    // Находим индексы игроков в составе
    int? player1Index;
    int? player2Index;

    for (int i = 0; i < currentSquad.length; i++) {
      final player = currentSquad[i].$2;
      if (player?.id == player1Id) {
        player1Index = i;
      }
      if (player?.id == player2Id) {
        player2Index = i;
      }

      // Если нашли оба индекса, выходим из цикла
      if (player1Index != null && player2Index != null) {
        break;
      }
    }

    // Если не нашли обоих игроков, выходим
    if (player1Index == null || player2Index == null) {
      return;
    }

    // Создаем копию состава
    final newSquad = List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)>.from(currentSquad);

    // Меняем игроков местами, сохраняя их позиции на поле
    final player1Data = newSquad[player1Index];
    final player2Data = newSquad[player2Index];

    newSquad[player1Index] = (player1Data.$1, player2Data.$2); // Сохраняем позицию первого игрока, но ставим второго
    newSquad[player2Index] = (player2Data.$1, player1Data.$2); // Сохраняем позицию второго игрока, но ставим первого

    _startingSquadSubject.add(newSquad);

    _selectedPlayerSubject.add(null);
  }

  Future<void> openPlayerSelector(FootballPlayerPositionOnField pof) async {
    _selectedPlayerSubject.add(null);

    final playersIdsToExclude = _startingSquadSubject.value.map((p) => p.$2?.id).nonNulls.toList();

    final player = await BottomSheetController.showBottomSheet<FootballPlayerGameModel?>(
      context,
      (context) => DraftPlayersScreen(
        args: DraftPlayersScreenArguments(
          playersIdsToExclude: playersIdsToExclude,
          position: pof.abstractPosition,
          draftPlayers: _draftPlayers[pof.abstractPosition] ?? [],
        ),
      ),
    );

    if (player == null) {
      return;
    }

    final oldSquad = _startingSquadSubject.value;
    final newSquad = oldSquad.map((p) {
      if (p.$1 == pof) {
        return (p.$1, player);
      }
      return p;
    }).toList();
    _startingSquadSubject.add(newSquad);
  }

  void selectCaptain(String playerId) {
    _captainIdSubject.add(playerId);
  }

  List<PositionConnection> getPositionConnections() {
    final yourScheme = _schemeSubject.value;
    final positions = FootballSchemes.vertical[yourScheme] ?? [];
    final startingSquad = _startingSquadSubject.value;
    final connections = <PositionConnection>[];

    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        final fromPof = positions[i];
        final toPof = positions[j];

        if (FootballSchemeConnections.shouldConnect(fromPof, toPof, yourScheme)) {
          final fromPlayer = startingSquad.firstWhereOrNull((p) => p.$1.id == fromPof.id)?.$2;
          final toPlayer = startingSquad.firstWhereOrNull((p) => p.$1.id == toPof.id)?.$2;

          if (fromPlayer != null && toPlayer != null) {
            final chemistry = _playersChemistry(fromPlayer, toPlayer);
            connections.add(PositionConnection(from: fromPof, to: toPof, chemistry: chemistry));
          }
        }
      }
    }

    return connections;
  }

  void _calcSquadChemistry() {
    final schemePofs = FootballSchemes.vertical[_schemeSubject.value] ?? [];
    final schemeConnections = FootballSchemeConnections.getConnectionsForScheme(_schemeSubject.value);

    final List<(PositionConnectionRule, double)> connectionsChemistry = [];
    for (final pof in schemePofs) {
      for (final connection in schemeConnections) {
        if (connection.fromPositionId == pof.id) {
          final player1 = _startingSquadSubject.value.firstWhereOrNull((p) => p.$1.id == pof.id);
          final player2 = _startingSquadSubject.value.firstWhereOrNull((p) => p.$1.id == connection.toPositionId);
          if (player1?.$2 != null && player2?.$2 != null) {
            final chemistry = _playersChemistry(player1!.$2!, player2!.$2!);
            connectionsChemistry.add((connection, chemistry));
          }
        }
      }
    }
    _connectionsChemistrySubject.add(connectionsChemistry);
  }

  double _playersChemistry(FootballPlayerGameModel player1, FootballPlayerGameModel player2) {
    final allCoounries = getIt.get<AllCountriesBloc>().state.countries;

    final player1CountryName = allCoounries?.firstWhereOrNull((c) => c.id == player1.card.countryId)?.name ?? '';
    final FootballConfederations player1Confederation = footballConfederationFromCountryName(player1CountryName);

    final player2CountryName = allCoounries?.firstWhereOrNull((c) => c.id == player2.card.countryId)?.name ?? '';
    final FootballConfederations player2Confederation = footballConfederationFromCountryName(player2CountryName);

    double chemistry = 0.0;

    // Одна конфедерация - средний бонус
    if (player1Confederation == player2Confederation) {
      chemistry += 0.5;
    }

    // Одна сборная - самый сильный бонус
    if (player1.card.countryId == player2.card.countryId) {
      chemistry += 0.65;
    }

    // Одна команда - самый сильный бонус
    if (player1.card.currentClub == player2.card.currentClub) {
      chemistry += 0.65;
    }

    return chemistry.clamp(0.0, 1.0);
  }

  void submitSquad() {
    final scheme = _schemeSubject.value;
    final startingSquad = _startingSquadSubject.value;
    final captainId = _captainIdSubject.value;

    if (startingSquad.length != 11 || captainId == null) {
      return;
    }

    final userTeam = FootballTeamGameModel(
      id: "user",
      name: AppGlossary.you.translate(),
      color: Colors.purple,
      scheme: scheme,
      players: startingSquad
          .mapIndexed(
            (index, tuple) =>
                FootballPlayerInTeamGameModel(teamId: "user", number: index + 1, pof: tuple.$1, data: tuple.$2!),
          )
          .toList(),
      captainId: captainId,
    );

    getIt.get<DraftTournamentBloc>().add(DraftTournamentEventStart(userTeam: userTeam));

    context.push(RoutePaths.draftTournamentStage);
  }

  @override
  void dispose() {
    super.dispose();
    _schemeSubject.close();
    _startingSquadSubject.close();
    _draftPageSubject.close();
    _captainIdSubject.close();
    _selectedPlayerSubject.close();
    _connectionsChemistrySubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
