part of '../saved_player_card.dart';

class _PlayerCardBackWidget extends StatelessWidget {
  const _PlayerCardBackWidget({
    required this.height,
    required this.width,
    required this.player,
  });

  final double height;
  final double width;
  final PlayerModel player;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (parseCustomDate(player.birthDate) != null)
                _RoundedWhiteContainer(text: parseCustomDate(player.birthDate)!),
              if (player.foot != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("foot:  "),
                    _RoundedWhiteContainer(text: player.foot!),
                  ],
                ),
              if (player.height != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("height:  "),
                    _RoundedWhiteContainer(text: player.height!),
                  ],
                ),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("current:  "),
                    _RoundedWhiteContainer(text: beautifyTransferValue(player.currentMarketValue!)),
                  ],
                ),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("prime:  "),
                    _RoundedWhiteContainer(text: beautifyTransferValue(player.maxMarketValue!)),
                  ],
                ),
              if (player.currentClub != null) _RoundedWhiteContainer(text: player.currentClub!.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
