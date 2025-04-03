import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';
import 'package:intl/intl.dart';

import '../../domain/models/player.dart';
import '../screens/open_pack_screen/open_pack_screen.dart';

String? parseCustomDate(String? dateString) {
  if (dateString == null) return null;
  String cleanedString = dateString.replaceAll(RegExp(r'\s*\(\d+\)\s*$'), '').trim();
  final dateTime = DateFormat('MMM d, y').parse(cleanedString);
  return DateFormat('dd.MM.yyyy').format(dateTime);
}

class SavedPlayerCard extends StatefulWidget {
  const SavedPlayerCard({
    required this.player,
    required this.count,
    this.hideTransferValue,
    this.height = packHeight,
    this.width = packWidth,
    this.enableFlip = false,
    super.key,
  });

  final PlayerModel player;
  final int count;
  final bool? hideTransferValue;
  final bool enableFlip;
  final double height;
  final double width;

  @override
  State<SavedPlayerCard> createState() => _SavedPlayerCardState();
}

class _SavedPlayerCardState extends State<SavedPlayerCard> {
  final FlipCardController flipCardController = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

    final faceImage = Image.asset(
      "assets/raster/player_faces/${widget.player.id}.jpg",
      fit: BoxFit.cover,
    );

    final card = Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 30,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: widget.count > 1
                  ? Banner(
                      location: BannerLocation.topEnd,
                      message: 'x${widget.count}',
                      color: Colors.green,
                      textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
                      // textDirection: TextDirection.ltr,
                      child: faceImage,
                    )
                  : faceImage,
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                'assets/raster/team_flags/${widget.player.countryId}.png',
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
                  padding: const EdgeInsets.only(right: 4, bottom: 4),
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    alignment: WrapAlignment.end,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.player.currentMarketValue != null && widget.hideTransferValue != null)
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            border: Border.all(),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              widget.hideTransferValue!
                                  ? "?"
                                  : beautifyTransferValue(widget.player.currentMarketValue!),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      if (widget.player.position != null) _RoundedWhiteContainer(text: widget.player.position!),
                      // DecoratedBox(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(32)),
                      //     border: Border.all(),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //     child: Text(
                      //       widget.player.position!,
                      //       maxLines: 1,
                      //       style: const TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // if (player.height != null)
                      //   DecoratedBox(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(32)),
                      //       border: Border.all(),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //       child: Text(
                      //         player.height!,
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),

                      // if (parseCustomDate(player.birthDate) != null)
                      //   DecoratedBox(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(32)),
                      //       border: Border.all(),
                      //     ),
                      //     child: Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //       child: Text(
                      //         parseCustomDate(player.birthDate)!,
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                SizedBox(
                  width: mq.size.width,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: AutoSizeText(
                      widget.player.name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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

    if (widget.enableFlip) {
      return GestureDetector(
        onTap: () {
          flipCardController.flipcard();
        },
        child: FlipCard(
          controller: flipCardController,
          rotateSide: RotateSide.right,
          backWidget: _PlayerCardBackWidget(
            height: widget.height,
            width: widget.width,
            player: widget.player,
          ),
          frontWidget: card,
        ),
      );
    }
    return card;
  }
}

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
              if (player.currentClub != null) _RoundedWhiteContainer(text: player.currentClub!),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundedWhiteContainer extends StatelessWidget {
  const _RoundedWhiteContainer({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(text),
      ),
    );
  }
}
