import 'package:flutter/material.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';

part 'get_player_by_qr_screen_presenter.dart';

class GetPlayerByQrScreen extends StatelessWidget {
  const GetPlayerByQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GetPlayerByQrScreenPresenter(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            BackgroundImage(),
            SizedBox(
              width: mq.size.width,
              child: Column(
                children: [
                  TransparentAppbar(title: "QR Scanner", showBalance: false),
                  const Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      ToastService.showToast(title: "Player added to your collection!", seconds: 2);
                    },
                    onTap: () {
                      ToastService.showErrorToast(title: "Can't find this player :(", seconds: 2);
                    },
                    child: Container(
                      color: Colors.white,
                      width: mq.size.width / 2,
                      height: mq.size.width / 2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Scan your friend's QR to get players!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
