part of '../draft_football_player_card.dart';

class _PriceAndPosition extends StatelessWidget {
  const _PriceAndPosition({required this.player, required this.hideTransferValue});

  final FootballPlayerCardModel player;
  final bool? hideTransferValue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5,
      right: 5,
      child: Wrap(
        spacing: 4,
        children: [
          if (player.currentMarketValue != null && hideTransferValue != null)
            _RoundedContainer(text: hideTransferValue! ? "?" : beautifyTransferValue(player.currentMarketValue!)),
          if (player.position != null)
            _RoundedContainer(
              text: player.position!.name.toUpperCase(),
              backgroundColor: player.position!.role?.color ?? Colors.purple,
              textColor: player.position!.role?.color != null ? Colors.white : null,
              borderColor: player.position!.role?.color != null ? Colors.white : null,
            ),
        ],
      ),
    );
  }
}
