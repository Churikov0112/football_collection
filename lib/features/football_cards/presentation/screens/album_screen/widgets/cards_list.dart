part of '../football_players_album_screen.dart';

class _FootballCardsList extends StatelessWidget {
  const _FootballCardsList({required this.country});

  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllFootballCardsBloc, AllFootballCardsState>(
      bloc: getIt.get(),
      builder: (context, allFootballCardsState) {
        final cards = (allFootballCardsState.cards ?? []).where((p) => p.teamId == country.id).toList();

        // тренер выводится первым
        cards.sort((a, b) => (b is FootballCoachCardModel ? 1 : 0).compareTo(a is FootballCoachCardModel ? 1 : 0));

        return Expanded(
          child: CardsGrid.album(cards: cards, country: country),
        );
      },
    );
  }
}
