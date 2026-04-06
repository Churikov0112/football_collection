part of '../football_players_album_screen.dart';

class _FootballCardsList extends StatelessWidget {
  const _FootballCardsList({required this.country});

  final FootballNationalTeamModel country;

  int _getPriority(CardModel card) {
    return switch (card) {
      FootballTeamEmblemCardModel() => 0,
      FootballCoachCardModel() => 1,
      FootballPlayerCardModel() => 2,
      FootballLegendCardModel() => 3,
      _ => 4,
    };
  }

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<CommonFootballRepository>();

    return FutureBuilder<List<CardModel>>(
      future: repo.getCards(cardTypes: CardType.values.toSet(), team: country),
      builder: (context, allFootballCardsState) {
        final cards = allFootballCardsState.data ?? [];

        // эмблема выводится выводится первой, тренер вторым, потом игроки в следующем порядке
        // вратари
        // защитники
        // полузащитники
        // нападающие
        // в конце выводятся легенды

        final sortedCards = List<CardModel>.from(cards)
          ..sort((a, b) {
            final priorityA = _getPriority(a);
            final priorityB = _getPriority(b);
            return priorityA.compareTo(priorityB);
          });

        return Expanded(
          child: CardsGrid.album(cards: sortedCards, country: country),
        );
      },
    );
  }
}
