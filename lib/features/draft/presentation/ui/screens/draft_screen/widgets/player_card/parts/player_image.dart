part of '../draft_football_player_card.dart';

class _FootballPlayerImage extends StatelessWidget {
  const _FootballPlayerImage({
    required this.player,
    required this.size,
    super.key,
  });

  final FootballPlayerCardModel player;
  final double size;

  @override
  Widget build(BuildContext context) {
    final faceImage = Image.asset(
      player.imageAssetPath,
      // isFake ? "assets/raster/other/player_0.png" : player.imageAssetPath,
      height: size,
      width: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Image.asset(
        "assets/raster/other/player_0.png",
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );

    return faceImage;
  }
}
