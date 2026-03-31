part of '../football_players_album_screen.dart';

class _CoachAlbumWidget extends StatelessWidget {
  const _CoachAlbumWidget({required this.coach, required this.country});

  final FootballCoachCardModel coach;
  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    // return SavedPlayerCard(player: player);

    final absentWIdget = Container(
      color: country.confederation.color?.darken().withAlpha(200),
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
          final count = savedCardsState.savedCardsIds?.where((id) => id == coach.cardId).length ?? 1;
          if (isCardSaved) {
            return FootballCoachCard(coach: coach, count: count, enableFlip: true);
          }
        }
        return absentWIdget;
      },
    );
  }
}
