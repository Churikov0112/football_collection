part of '../../card_image_wrapper.dart';

class _LegendTopLeft extends StatelessWidget {
  const _LegendTopLeft({required this.legend});

  final FootballLegendCardModel legend;

  @override
  Widget build(BuildContext context) {
    final hasNumber = legend.teamShirtNumber != null && legend.teamShirtNumber != "-";

    return Column(
      children: [
        if (legend.position case final position?) _PositionTopLeft(position: position),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: hasNumber ? null : BorderRadius.only(bottomRight: .circular(8)),
            image: DecorationImage(image: AssetImage('assets/raster/teams_flags/${legend.teamId}.jpg')),
          ),
          child: SizedBox.square(dimension: _kTopLeftElementSize),
        ),

        if (legend.teamShirtNumber != null && legend.teamShirtNumber != "-")
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
              borderRadius: BorderRadius.only(bottomRight: .circular(8)),
            ),
            child: SizedBox.square(
              dimension: _kTopLeftElementSize,
              child: Center(
                child: Text(
                  "#${legend.teamShirtNumber}",
                  style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
