import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:throttling/throttling.dart';

part 'get_card_by_qr_screen_presenter.dart';

class GetCardByQrScreen extends StatelessWidget {
  const GetCardByQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GetCardByQrScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = GetCardByQrScreenPresenter.of(context);

          return Scaffold(
            // backgroundColor: Colors.black,
            body: Stack(
              children: [
                // BackgroundImage(),
                Column(
                  children: [
                    Translator(
                      termin: AppGlossary.scanQr,
                      builder: (value) => TransparentAppbar(
                        title: value,
                        showBalance: false,
                      ),
                    ),
                    const Spacer(),
                    SizedBox.square(
                      dimension: mq.size.width * 0.8,
                      child: MobileScanner(
                        controller: presenter.mobileScannerController,
                        onDetect: presenter._handleBarcode,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: mq.size.width * 0.8,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Translator(
                            termin: AppGlossary.scanYourFriendQrToGetPlayer,
                            builder: (value) => Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
