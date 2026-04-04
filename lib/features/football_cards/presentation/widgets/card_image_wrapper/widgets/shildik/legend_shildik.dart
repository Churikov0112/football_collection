part of '../../card_image_wrapper.dart';

class _LegendShildik extends StatelessWidget {
  const _LegendShildik({required this.innerBorderRadius});

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
            "LEGEND",
            style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
