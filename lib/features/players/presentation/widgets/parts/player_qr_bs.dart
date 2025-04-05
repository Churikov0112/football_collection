part of '../saved_player_card.dart';

class _PlayerQrBottomSheet extends StatelessWidget {
  const _PlayerQrBottomSheet();

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
            Container(
              width: mq.size.width / 2,
              height: mq.size.width / 2,
              color: Colors.black,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: mq.size.width * 0.7,
              child: Text(
                "Open QR Scanner on second device from side menu and scan code",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
