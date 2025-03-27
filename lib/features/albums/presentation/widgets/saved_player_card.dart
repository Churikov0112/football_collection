import 'package:flutter/material.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';

import '../../domain/models/player.dart';
import '../screens/sticker_pack_screen/sticker_pack_screen.dart';

class SavedPlayerCard extends StatelessWidget {
  const SavedPlayerCard({
    required this.player,
    required this.count,
    this.hideTransferValue = false,
    this.height = packHeight,
    this.width = packWidth,
    super.key,
  });

  final PlayerModel player;
  final int count;
  final bool hideTransferValue;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

    final faceImage = Image.asset(
      "assets/raster/player_faces/${player.id}.jpg",
      fit: BoxFit.cover,
    );

    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 30,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: count > 1
                    ? Banner(
                        location: BannerLocation.topEnd,
                        message: 'x$count',
                        color: Colors.green,
                        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
                        textDirection: TextDirection.ltr,
                        child: faceImage,
                      )
                    : faceImage,
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                'assets/raster/team_flags/${player.countryId}.png',
                height: 32,
                width: 32,
              ),
            ),
          ),
          // Positioned(
          //   top: 5,
          //   right: 5,
          //   child: Row(
          //     children: [
          //       DecoratedBox(
          //         decoration: const BoxDecoration(
          //           image: DecorationImage(image: AssetImage("assets/shirt.png")),
          //         ),
          //         child: SizedBox(
          //           height: 32,
          //           width: 32,
          //           child: Center(
          //             child: Text(
          //               player.number.toString(),
          //               style: const TextStyle(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (player.currentMarketValue != null)
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            border: Border.all(),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 32,
                              maxHeight: 32,
                              minWidth: 32,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  hideTransferValue ? "?" : beautifyTransferValue(player.currentMarketValue!),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: SizedBox(
                          height: 32,
                          width: 32,
                          child: Center(
                            child: Text(
                              player.position ?? "?",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: BorderDirectional(top: BorderSide()),
                  ),
                  child: SizedBox(
                    width: mq.size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(
                        player.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
