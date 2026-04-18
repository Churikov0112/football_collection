part of '../../card_image_wrapper/card_image_wrapper.dart';

class CardQrBottomSheet extends StatelessWidget {
  const CardQrBottomSheet({required this.card, super.key});

  final CardModel card;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 30, 30, 30)),
      child: SizedBox(
        width: mq.size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Translator(
                      termin: AppGlossary.shareViaQr,
                      builder: (value) {
                        return Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20));
                      },
                    ),
                  ),
                  IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
                ],
              ),
            ),
            const Spacer(),
            const SizedBox(height: 32),
            DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: QrImageView(data: card.cardId, version: QrVersions.auto, size: mq.size.width / 2),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: mq.size.width * 0.7,
              child: Text(AppGlossary.openQrScannerOnSecondDevice.translate(), textAlign: TextAlign.center),
            ),
            const SizedBox(height: 8),
            Text(
              AppGlossary.or.translate(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text("${AppGlossary.enterManuallyAsCheatCode.translate()}:", textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: .min,
              children: [
                Text(
                  card.cardId,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: card.cardId));
                    ToastService.showToast(title: AppGlossary.copiedToClipboard.translate());
                  },
                  icon: const Icon(Icons.copy),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
