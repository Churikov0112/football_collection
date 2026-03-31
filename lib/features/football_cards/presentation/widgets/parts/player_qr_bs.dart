part of '../football_player_card.dart';

class _PlayerQrBottomSheet extends StatelessWidget {
  const _PlayerQrBottomSheet({required this.player});

  final FootballPlayerCardModel player;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: mq.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.white),
              child: QrImageView(data: player.cardId, version: QrVersions.auto, size: mq.size.width / 2),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: mq.size.width * 0.7,
              child: Text(AppGlossary.openQrScannerOnSecondDevice.translate(), textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
