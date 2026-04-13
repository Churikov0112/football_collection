part of '../cards_grid.dart';

class _FootballCoachAlbumWidget extends StatelessWidget {
  const _FootballCoachAlbumWidget({required this.coach, required this.country});

  final FootballCoachCardModel coach;
  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    // return SavedPlayerCard(player: player);

    final absentWidget = Container(
      // color: country.confederation.color?.darken().withAlpha(200),
      color: Colors.blueAccent.darken(0.3).withAlpha(180),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              coach.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            Icon(Icons.person, size: 64, color: Colors.white54),
            Text(
              "Coach",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
          ],
        ),
      ),
    );

    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get(),
      buildWhen: (previous, current) => current is SavedCardsStateLoadSucceeded,
      builder: (context, savedCardsState) {
        if (savedCardsState is SavedCardsStateLoadSucceeded) {
          final isCardSaved = savedCardsState.savedCardsIds?.contains(coach.cardId) ?? false;
          if (isCardSaved) {
            return FootballCoachCardWidget(coach: coach, badge: .showCount);
          }
        }
        return absentWidget;
      },
    );
  }
}
