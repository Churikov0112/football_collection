part of '../album_screen.dart';

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.player,
    required this.country,
  });

  final PlayerModel player;
  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    // return SavedPlayerCard(player: player);

    final absentWIdget = Container(
      color: country.confederation.color?.darken(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              player.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            Icon(
              Icons.person,
              size: 64,
              color: Colors.white54,
            ),
            Text(
              player.position ?? "?",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );

    return BlocBuilder<SavedPlayersBloc, SavedPlayersState>(
      bloc: getIt.get(),
      buildWhen: (previous, current) => current is SavedPlayersStateLoadSucceeded,
      builder: (context, savedPlayersState) {
        if (savedPlayersState is SavedPlayersStateLoadSucceeded) {
          final isPlayerSaved = savedPlayersState.savedIds?.contains(player.id) ?? false;
          final count = savedPlayersState.savedIds?.where((id) => id == player.id).length ?? 1;
          if (isPlayerSaved) {
            return SavedPlayerCard(player: player, count: count);
          }
        }
        return absentWIdget;
      },
    );
  }
}
