import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../../services/localization/translator.dart';
import '../../../../../abstract/domain/models/card.dart';

class CardQrBottomSheet extends StatelessWidget {
  const CardQrBottomSheet({super.key, required this.card});

  final CardModel card;

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
              child: QrImageView(data: card.cardId, version: QrVersions.auto, size: mq.size.width / 2),
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
