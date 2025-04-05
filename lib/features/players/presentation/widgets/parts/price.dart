part of '../saved_player_card.dart';

class _Price extends StatelessWidget {
  const _Price({
    required this.player,
    required this.hideTransferValue,
  });

  final PlayerModel player;
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
            _RoundedWhiteContainer(text: hideTransferValue! ? "?" : beautifyTransferValue(player.currentMarketValue!)),
          if (player.position != null) _RoundedWhiteContainer(text: player.position!),
        ],
      ),
    );
  }
}
