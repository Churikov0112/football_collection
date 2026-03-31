part of '../football_coach_card.dart';

class _PlayerImage extends StatelessWidget {
  const _PlayerImage({required this.coach, required this.count, required this.showNew});

  final int count;
  final bool showNew;
  final FootballCoachCardModel coach;

  @override
  Widget build(BuildContext context) {
    final faceImage = Image.asset(
      coach.imageAssetPath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Colors.white,
        child: Center(child: Icon(Icons.no_photography, size: 64, color: Colors.black54)),
      ),
    );

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border.all(color: Colors.black54, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: count > 1
              ? Banner(
                  location: BannerLocation.topEnd,
                  message: 'x$count',
                  color: Colors.green,
                  textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
                  child: faceImage,
                )
              : showNew
              ? Banner(
                  location: BannerLocation.topEnd,
                  message: 'New!',
                  color: const Color(0xFF7B1FA2),
                  textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
                  child: faceImage,
                )
              : faceImage,
        ),
      ),
    );
  }
}

// class CoachImage extends StatelessWidget {
//   const CoachImage({required this.player, required this.size, required this.isFake, super.key});

//   final FootballPlayerCardModel player;
//   final double size;
//   final bool isFake;

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       player.imageAssetPath,
//       // isFake ? "assets/raster/other/player_0.png" : player.imageAssetPath,
//       width: size,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) =>
//           Image.asset("assets/raster/other/player_0.png", height: size, width: size, fit: BoxFit.cover),
//     );
//   }
// }
