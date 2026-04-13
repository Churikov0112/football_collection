part of '../../card_image_wrapper.dart';

class _CoachTopLeft extends StatelessWidget {
  const _CoachTopLeft({required this.coach});

  final FootballCoachCardModel coach;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: .circular(8)),
            image: DecorationImage(image: AssetImage('assets/raster/teams_flags/${coach.teamId}.jpg')),
          ),
          child: SizedBox.square(dimension: _kTopLeftElementSize),
        ),
      ],
    );
  }
}
