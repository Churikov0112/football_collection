part of '../football_players_duplicates_screen.dart';

class _DuplicatesGrid extends StatelessWidget {
  const _DuplicatesGrid({required this.cards});

  final List<CardModel> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(
        child: Translator(
          termin: AppGlossary.noDuplicates,
          builder: (value) => Text(value, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ),
      );
    }

    final mq = MediaQuery.of(context);

    return CardsGrid(
      cards: cards,
      badge: CardBadge.showCount,
      padding: EdgeInsets.only(top: mq.padding.top + 160, left: 16, right: 16, bottom: mq.padding.bottom + 16),
    );
  }
}
