part of '../saved_player_card.dart';

class _PlayerImage extends StatelessWidget {
  const _PlayerImage({
    required this.player,
    required this.count,
  });

  final int count;
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    final faceImage = Image.asset(
      "assets/raster/player_faces/${player.id}.jpg",
      fit: BoxFit.cover,
    );

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: count > 1
              ? Banner(
                  location: BannerLocation.topEnd,
                  message: 'x$count',
                  color: Colors.green,
                  textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
                  // textDirection: TextDirection.ltr,
                  child: faceImage,
                )
              : faceImage,
        ),
      ),
    );
  }
}
