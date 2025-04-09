import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'get_player_by_qr_screen_presenter.dart';

class GetPlayerByQrScreen extends StatelessWidget {
  const GetPlayerByQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GetPlayerByQrScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = GetPlayerByQrScreenPresenter.of(context);

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
                        onDetect: presenter.handleBarcode,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: mq.size.width * 0.8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
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
