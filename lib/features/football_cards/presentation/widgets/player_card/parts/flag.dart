part of '../football_player_card.dart';

class _Flag extends StatelessWidget {
  const _Flag({required this.player, required this.nationalTeamVisibility});

  final FootballPlayerCardModel player;
  final CardElementVisibility nationalTeamVisibility;

  @override
  Widget build(BuildContext context) {
    if (nationalTeamVisibility == .none) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: nationalTeamVisibility == .quest ? Colors.white : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: nationalTeamVisibility == .quest
              ? SizedBox.square(
                  dimension: 32,
                  child: CircleAvatar(backgroundColor: Colors.white, child: Text("?")),
                )
              : nationalTeamVisibility == .show
              ? Image.asset('assets/raster/teams_flags/${player.teamId}.jpg', height: 32, width: 32)
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
