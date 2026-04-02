part of '../football_players_album_screen.dart';

class _FootballCardsList extends StatelessWidget {
  const _FootballCardsList({required this.country});

  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<CommonFootballRepository>();

    return FutureBuilder<List<CardModel>>(
      future: repo.getAllCards(cardTypes: CardType.values.toSet()),
      builder: (context, allFootballCardsState) {
        final cards = (allFootballCardsState.data ?? []).where((p) => p.teamId == country.id).toList();

        // тренер выводится первым
        cards.sort((a, b) => (b is FootballCoachCardModel ? 1 : 0).compareTo(a is FootballCoachCardModel ? 1 : 0));

        return Expanded(
          child: CardsGrid.album(cards: cards, country: country),
        );
      },
    );
  }
}
