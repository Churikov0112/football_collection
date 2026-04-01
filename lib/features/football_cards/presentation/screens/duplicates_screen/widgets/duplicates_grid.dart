part of '../football_players_duplicates_screen.dart';

class _DuplicatesGrid extends StatelessWidget {
  const _DuplicatesGrid({required this.items, required this.bottomPadding});

  final List<_DuplicateItem> items;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Translator(
          termin: AppGlossary.noDuplicates,
          builder: (value) => Text(value, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ),
      );
    }

    return CardsGrid(cards: items.map((e) => e.card).toList(), badge: CardBadge.showCount);
  }
}
