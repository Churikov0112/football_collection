part of '../../card_image_wrapper.dart';

class _PlayerTopLeft extends StatelessWidget {
  const _PlayerTopLeft({required this.player, required this.nationalTeamVisibility});

  final FootballPlayerCardModel player;
  final CardElementVisibility nationalTeamVisibility;

  @override
  Widget build(BuildContext context) {
    final hasNumber = player.teamShirtNumber != null && player.teamShirtNumber != "-";

    return Column(
      children: [
        if (player.position case final position?) _PositionTopLeft(position: position),

        if (nationalTeamVisibility == .show)
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: hasNumber ? null : BorderRadius.only(bottomRight: .circular(8)),
              image: DecorationImage(image: AssetImage('assets/raster/team_flags/${player.teamId}.jpg')),
            ),
            child: SizedBox.square(dimension: _kTopLeftElementSize),
          )
        else if (nationalTeamVisibility == .quest)
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: hasNumber ? null : BorderRadius.only(bottomRight: .circular(8)),
              color: Colors.lightGreenAccent,
            ),
            child: SizedBox.square(
              dimension: _kTopLeftElementSize,
              child: Center(
                child: Text(
                  "?",
                  style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        else
          const SizedBox.shrink(),

        if (hasNumber)
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.only(bottomRight: .circular(8)),
            ),
            child: SizedBox.square(
              dimension: _kTopLeftElementSize,
              child: Center(
                child: Text(
                  "#${player.teamShirtNumber}",
                  style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
