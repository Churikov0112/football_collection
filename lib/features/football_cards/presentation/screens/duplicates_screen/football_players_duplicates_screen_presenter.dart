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

  @override
  void initState() {
    super.initState();

    final allCardsBloc = getIt.get<AllFootballCardsBloc>();
    if (allCardsBloc.state is! AllFootballCardsStateLoadSucceeded) {
      allCardsBloc.add(AllFootballCardsEventLoad());
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<_DuplicateItem> buildItems(List<CardModel> allPlayers, List<String> savedIds, String searchQuery) {
    final query = searchQuery.trim().toLowerCase();
    final items = _buildDuplicateItems(
      allPlayers,
      savedIds,
    ).where((item) => item.count >= 2).where((item) => _filterBySearch(item.card, query)).toList();

    return items;
  }

  bool _filterBySearch(CardModel card, String query) {
    if (query.isEmpty) return true;
    return card.name.toLowerCase().contains(query);
  }

  List<_DuplicateItem> _buildDuplicateItems(List<CardModel> cards, List<String> savedIds) {
    final counts = <String, int>{};
    for (final id in savedIds) {
      counts[id] = (counts[id] ?? 0) + 1;
    }

    final cardsById = <String, CardModel>{};
    for (final card in cards) {
      cardsById[card.cardId] = card;
    }

    final items = <_DuplicateItem>[];
    for (final entry in counts.entries) {
      if (entry.value < 2) continue;
      final card = cardsById[entry.key];
      if (card == null) continue;
      items.add(_DuplicateItem(card: card, count: entry.value));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _DuplicateItem {
  final CardModel card;
  final int count;

  const _DuplicateItem({required this.card, required this.count});
}
