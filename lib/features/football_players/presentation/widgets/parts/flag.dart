part of '../football_player_card.dart';

class _Flag extends StatelessWidget {
  const _Flag({required this.player, required this.hideNationalTeam});

  final FootballPlayerCardModel player;
  final bool hideNationalTeam;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      left: 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: hideNationalTeam ? Colors.white : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: hideNationalTeam
                ? SizedBox.square(
                    dimension: 32,
                    child: CircleAvatar(backgroundColor: Colors.white, child: Text("?")),
                  )
                : Image.asset('assets/raster/team_flags/${player.countryId}.png', height: 32, width: 32),
          ),
        ),
      ),
    );
  }
}
