part of '../football_player_card.dart';

class _PriceAndPosition extends StatelessWidget {
  const _PriceAndPosition({
    required this.player,
    required this.hideTransferValue,
  });

  final FootballPlayerModel player;
  final bool? hideTransferValue;

  @override
  Widget build(BuildContext context) {
    final positionBackgroundColor = footballPlayerPositionToColor(player.position!);

    return Positioned(
      bottom: 5,
      right: 5,
      child: Wrap(
        spacing: 4,
        children: [
          if (player.currentMarketValue != null && hideTransferValue != null)
            _RoundedContainer(
              text: hideTransferValue! ? "?" : beautifyTransferValue(player.currentMarketValue!),
            ),
          if (player.position != null)
            _RoundedContainer(
              text: footballPlayerPositionToShort(player.position!)!,
              backgroundColor: positionBackgroundColor,
              textColor: positionBackgroundColor != null ? Colors.white : null,
              borderColor: positionBackgroundColor,
            ),
        ],
      ),
    );
  }
}
