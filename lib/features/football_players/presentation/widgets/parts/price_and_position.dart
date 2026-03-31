part of '../football_player_card.dart';

class _PriceAndPosition extends StatelessWidget {
  const _PriceAndPosition({required this.player, required this.hideTransferValue});

  final FootballPlayerCardModel player;
  final bool? hideTransferValue;

  @override
  Widget build(BuildContext context) {
    final positionBackgroundColor = footballPlayerPositionToColor(player.position);
    final shortPosition = footballPlayerPositionToShort(player.position) ?? player.position;

    return Positioned(
      bottom: 5,
      right: 5,
      child: Wrap(
        spacing: 4,
        children: [
          if (player.marketValue != null && hideTransferValue != null)
            _RoundedContainer(text: hideTransferValue! ? "?" : beautifyTransferValue(player.marketValue!)),
          if (shortPosition != null)
            _RoundedContainer(
              text: shortPosition,
              backgroundColor: positionBackgroundColor,
              textColor: positionBackgroundColor != null ? Colors.white : null,
              borderColor: positionBackgroundColor != null ? Colors.white : null, // positionBackgroundColor,
            ),
        ],
      ),
    );
  }
}
