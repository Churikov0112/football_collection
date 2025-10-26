part of '../football_players_album_screen.dart';

class _FootballPlayerAlbumWidget extends StatelessWidget {
  const _FootballPlayerAlbumWidget({required this.player, required this.country});

  final FootballPlayerCardModel player;
  final CountryModel country;

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
              player.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            Icon(Icons.person, size: 64, color: Colors.white54),
            Text(
              player.position ?? "?",
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
          final isPlayerSaved = savedCardsState.savedCardsIds?.contains(player.cardId) ?? false;
          final count = savedCardsState.savedCardsIds?.where((id) => id == player.cardId).length ?? 1;
          if (isPlayerSaved) {
            return FootballPlayerCard(player: player, count: count, enableFlip: true);
          }
        }
        return absentWIdget;
      },
    );
  }
}
