part of '../saved_player_card.dart';

class _Flag extends StatelessWidget {
  const _Flag({
    required this.player,
  });

  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image.asset(
              'assets/raster/team_flags/${player.countryId}.png',
              height: 32,
              width: 32,
            ),
          ),
        ),
      ),
    );
  }
}
