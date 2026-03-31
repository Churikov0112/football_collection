part of '../football_players_album_screen.dart';

class _FootballCardsList extends StatelessWidget {
  const _FootballCardsList({required this.country});

  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<AllFootballCardsBloc, AllFootballCardsState>(
      bloc: getIt.get(),
      builder: (context, allFootballCardsState) {
        final cards = (allFootballCardsState.cards ?? []).where((p) => p.teamId == country.id).toList();

        // тренер выводится первым
        cards.sort((a, b) => (b is FootballCoachCardModel ? 1 : 0).compareTo(a is FootballCoachCardModel ? 1 : 0));

        return Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: EdgeInsets.only(top: mq.padding.top + 85, left: 20, right: 20, bottom: mq.padding.bottom + 100),
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              if (card is FootballPlayerCardModel) {
                return _FootballPlayerAlbumWidget(player: card, country: country);
              }

              if (card is FootballCoachCardModel) {
                return _CoachAlbumWidget(coach: card, country: country);
              }

              return SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
