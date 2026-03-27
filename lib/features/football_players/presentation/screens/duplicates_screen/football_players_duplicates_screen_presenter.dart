part of 'football_players_duplicates_screen.dart';

class FootballPlayersDuplicatesScreenPresenter extends StatefulWidget {
  static FootballPlayersDuplicatesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballPlayersDuplicatesScreenPresenterState>()!;
  }

  final Widget child;

  const FootballPlayersDuplicatesScreenPresenter({required this.child, super.key});

  @override
  State<FootballPlayersDuplicatesScreenPresenter> createState() => FootballPlayersDuplicatesScreenPresenterState();
}

class FootballPlayersDuplicatesScreenPresenterState extends State<FootballPlayersDuplicatesScreenPresenter> {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<_DuplicatesViewState> viewState = ValueNotifier(const _DuplicatesViewState());

  @override
  void initState() {
    super.initState();

    final allPlayersBloc = getIt.get<AllFootballPlayersBloc>();
    if (allPlayersBloc.state is! AllFootballPlayersStateLoadSucceeded) {
      allPlayersBloc.add(AllFootballPlayersEventLoad());
    }

    final allCountriesBloc = getIt.get<AllCountriesBloc>();
    if (allCountriesBloc.state is! AllCountriesStateLoadSucceeded) {
      allCountriesBloc.add(AllCountriesEventGet());
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    viewState.dispose();
    super.dispose();
  }

  Future<void> openFiltersSheet() async {
    final current = viewState.value;
    final countries = getIt.get<AllCountriesBloc>().state.countries ?? const <FootballNationalTeamModel>[];
    final result = await BottomSheetController.showBottomSheet<_FiltersResult>(
      context,
      (context) => _FiltersSheet(
        positionGroup: current.positionGroup,
        minCount: current.minCount,
        country: current.country,
        countries: countries,
      ),
    );

    if (result == null) return;
    viewState.value = _DuplicatesViewState(
      positionGroup: result.positionGroup,
      minCount: result.minCount,
      sortOption: current.sortOption,
      country: result.country,
    );
  }

  Future<void> openSortSheet() async {
    final current = viewState.value;
    final result = await BottomSheetController.showBottomSheet<_SortOption>(
      context,
      (context) => _SortSheet(current: current.sortOption),
    );

    if (result == null) return;
    viewState.value = _DuplicatesViewState(
      positionGroup: current.positionGroup,
      minCount: current.minCount,
      sortOption: result,
      country: current.country,
    );
  }

  List<_DuplicateItem> buildItems(
    List<FootballPlayerCardModel> allPlayers,
    List<String> savedIds,
    _DuplicatesViewState state,
    String searchQuery,
  ) {
    final query = searchQuery.trim().toLowerCase();
    final items = _buildDuplicateItems(allPlayers, savedIds)
        .where((item) => _filterByPosition(item.player, state.positionGroup))
        .where((item) => item.count >= state.minCount)
        .where((item) => _filterByCountry(item.player, state.country))
        .where((item) => _filterBySearch(item.player, query))
        .toList();

    _sortItems(items, state.sortOption);
    return items;
  }

  bool _filterBySearch(FootballPlayerCardModel player, String query) {
    if (query.isEmpty) return true;
    return player.name.toLowerCase().contains(query);
  }

  bool _filterByCountry(FootballPlayerCardModel player, FootballNationalTeamModel? country) {
    if (country == null) return true;
    final nameMatches = player.teamName?.toLowerCase() == country.name.toLowerCase();
    final idMatches = player.teamId == country.id;
    return nameMatches || idMatches;
  }

  bool _filterByPosition(FootballPlayerCardModel player, _PositionGroup positionGroup) {
    if (positionGroup == _PositionGroup.all) return true;
    final group = _positionGroupFor(player.position);
    return group == positionGroup;
  }

  List<_DuplicateItem> _buildDuplicateItems(List<FootballPlayerCardModel> players, List<String> savedIds) {
    final counts = <String, int>{};
    for (final id in savedIds) {
      counts[id] = (counts[id] ?? 0) + 1;
    }

    final playersById = <String, FootballPlayerCardModel>{};
    for (final player in players) {
      playersById[player.cardId] = player;
    }

    final items = <_DuplicateItem>[];
    for (final entry in counts.entries) {
      if (entry.value < 2) continue;
      final player = playersById[entry.key];
      if (player == null) continue;
      items.add(_DuplicateItem(player: player, count: entry.value));
    }
    return items;
  }

  void _sortItems(List<_DuplicateItem> items, _SortOption option) {
    int valueOf(_DuplicateItem item) => item.player.currentMarketValue ?? item.player.maxMarketValue ?? 0;

    switch (option) {
      case _SortOption.nameAsc:
        items.sort((a, b) => a.player.name.compareTo(b.player.name));
        break;
      case _SortOption.nameDesc:
        items.sort((a, b) => b.player.name.compareTo(a.player.name));
        break;
      case _SortOption.countDesc:
        items.sort((a, b) => b.count.compareTo(a.count));
        break;
      case _SortOption.countAsc:
        items.sort((a, b) => a.count.compareTo(b.count));
        break;
      case _SortOption.valueDesc:
        items.sort((a, b) => valueOf(b).compareTo(valueOf(a)));
        break;
      case _SortOption.valueAsc:
        items.sort((a, b) => valueOf(a).compareTo(valueOf(b)));
        break;
    }
  }

  _PositionGroup _positionGroupFor(String? position) {
    switch (position) {
      case "Goalkeeper":
        return _PositionGroup.gk;
      case "Centre-Back":
      case "Left-Back":
      case "Right-Back":
        return _PositionGroup.def;
      case "Defensive Midfield":
      case "Central Midfield":
      case "Attacking Midfield":
      case "Left Midfield":
      case "Right Midfield":
        return _PositionGroup.mid;
      case "Left Winger":
      case "Right Winger":
      case "Centre-Forward":
      case "Second Striker":
      case "Striker":
        return _PositionGroup.att;
      default:
        return _PositionGroup.all;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _DuplicatesViewState {
  final _PositionGroup positionGroup;
  final int minCount;
  final _SortOption sortOption;
  final FootballNationalTeamModel? country;

  const _DuplicatesViewState({
    this.positionGroup = _PositionGroup.all,
    this.minCount = 2,
    this.sortOption = _SortOption.countDesc,
    this.country,
  });

  bool get filtersDirty => positionGroup != _PositionGroup.all || minCount != 2 || country != null;
}

class _DuplicateItem {
  final FootballPlayerCardModel player;
  final int count;

  const _DuplicateItem({required this.player, required this.count});
}
