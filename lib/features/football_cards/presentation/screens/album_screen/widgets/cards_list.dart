part of '../football_players_album_screen.dart';

class _FootballCardsList extends StatelessWidget {
  const _FootballCardsList({required this.country});

  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<CommonFootballRepository>();

    return FutureBuilder<List<CardModel>>(
      future: repo.getCards(cardTypes: CardType.values.toSet(), team: country),
      builder: (context, allFootballCardsState) {
        final cards = allFootballCardsState.data ?? [];

        // эмблема выводится выводится первой, тренер вторым, легенды в конце
        cards.sort((a, b) {
          if (a.cardType == .emblem) return -1;
          if (b.cardType == .emblem) return 1;
          if (a.cardType == .coach) return -1;
          if (b.cardType == .coach) return 1;
          return 0;
        });

        return Expanded(
          child: CardsGrid.album(cards: cards, country: country),
        );
      },
    );
  }
}
