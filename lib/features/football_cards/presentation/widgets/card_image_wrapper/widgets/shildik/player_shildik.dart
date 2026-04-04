part of '../../card_image_wrapper.dart';

class _PlayerShildik extends StatelessWidget {
  const _PlayerShildik({required this.innerBorderRadius, required this.player});

  final Radius innerBorderRadius;
  final FootballPlayerCardModel player;

  @override
  Widget build(BuildContext context) {
    if (player.clubName == null) {
      return SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent,
        borderRadius: BorderRadius.only(topLeft: innerBorderRadius),
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),

          child: Text(
            player.clubName?.toUpperCase() ?? "NO CLUB",
            style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
