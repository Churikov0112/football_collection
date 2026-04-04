part of '../../card_image_wrapper.dart';

class _CoachShildik extends StatelessWidget {
  const _CoachShildik({required this.innerBorderRadius});

  final Radius innerBorderRadius;

  @override
  Widget build(BuildContext context) {
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
            "COACH",
            style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
