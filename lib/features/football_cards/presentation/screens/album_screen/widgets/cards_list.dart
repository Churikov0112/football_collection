part of '../football_players_album_screen.dart';

// Где-то в утилитах или рядом с footballPlayerPositionToShort
const Map<String, int> _footballPlayerPositionOrder = {
  "Goalkeeper": 0,
  "Centre-Back": 1,
  "Left-Back": 2,
  "Right-Back": 3,
  "Defensive Midfield": 4,
  "Central Midfield": 5,
  "Attacking Midfield": 6,
  "Left Midfield": 7,
  "Right Midfield": 8,
  "Left Winger": 9,
  "Right Winger": 10,
  "Centre-Forward": 11,
  "Second Striker": 12,
  "Striker": 13,
};

int _getFootballPlayerPositionOrder(String? position) {
  if (position == null) return 99;
  return _footballPlayerPositionOrder[position] ?? 99;
}

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

        final sortedCards = List<CardModel>.from(cards)
          ..sort((a, b) {
            // Сначала сортируем по типу карты
            final priorityA = _getPriority(a);
            final priorityB = _getPriority(b);

            if (priorityA != priorityB) {
              return priorityA.compareTo(priorityB);
            }

            // Если оба - игроки, сортируем по позиции
            if (a is FootballPlayerCardModel && b is FootballPlayerCardModel) {
              final positionOrderA = _getFootballPlayerPositionOrder(a.position);
              final positionOrderB = _getFootballPlayerPositionOrder(b.position);
              return positionOrderA.compareTo(positionOrderB);
            }

            return 0;
          });

        return Expanded(
          child: CardsGrid.album(cards: sortedCards, country: country),
        );
      },
    );
  }
}
