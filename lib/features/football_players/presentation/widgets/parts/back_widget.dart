part of '../football_player_card.dart';

class _PlayerCardBackWidget extends StatelessWidget {
  const _PlayerCardBackWidget({
    required this.height,
    required this.width,
    required this.player,
  });

  final double height;
  final double width;
  final FootballPlayerModel player;

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
                _RoundedContainer(text: parseCustomDate(player.birthDate)!),
              if (player.foot != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Translator(
                      termin: AppGlossary.foot,
                      builder: (value) => Text(
                        "$value:  ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _FootRoundedContainer(text: player.foot!),
                  ],
                ),
              if (player.height != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Translator(
                      termin: AppGlossary.height,
                      builder: (value) => Text(
                        "$value:  ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _RoundedContainer(text: player.height!),
                  ],
                ),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Translator(
                      termin: AppGlossary.currentValue,
                      builder: (value) => Text(
                        "$value:  ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _RoundedContainer(text: beautifyTransferValue(player.currentMarketValue!)),
                  ],
                ),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Translator(
                      termin: AppGlossary.primeValue,
                      builder: (value) => Text(
                        "$value:  ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    _RoundedContainer(text: beautifyTransferValue(player.maxMarketValue!)),
                  ],
                ),
              if (player.currentClub != null) _RoundedContainer(text: player.currentClub!.toUpperCase()),
            ],
          ),
        ),
      ),
    );
  }
}
