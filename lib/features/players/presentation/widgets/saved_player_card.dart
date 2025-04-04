import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';
import 'package:go_router/go_router.dart';
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
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Positioned.fill(
          //   bottom: 30,
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.black54, width: 1),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(1.0),
          //       child: widget.count > 1
          //           ? Banner(
          //               location: BannerLocation.topEnd,
          //               message: 'x${widget.count}',
          //               color: Colors.green,
          //               textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
          //               // textDirection: TextDirection.ltr,
          //               child: faceImage,
          //             )
          //           : faceImage,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 5,
          //   left: 5,
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.black54, width: 1),
          //       borderRadius: BorderRadius.all(Radius.circular(20)),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(1),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.all(Radius.circular(20)),
          //         child: Image.asset(
          //           'assets/raster/team_flags/${widget.player.countryId}.png',
          //           height: 32,
          //           width: 32,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
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
                ),

                // Positioned(
                //   top: 0,

                //   child: child,
                // ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          'assets/raster/team_flags/${widget.player.countryId}.png',
                          height: 32,
                          width: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.player.position != null)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: _RoundedWhiteContainer(text: widget.player.position!),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.player.name.toUpperCase(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          // Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 4, bottom: 4),
          //   child: Wrap(
          //     spacing: 2,
          //     runSpacing: 2,
          //     crossAxisAlignment: WrapCrossAlignment.end,
          //     alignment: WrapAlignment.end,
          //     // mainAxisSize: MainAxisSize.min,
          //     children: [
          //       if (widget.player.currentMarketValue != null && widget.hideTransferValue != null)
          //         _RoundedWhiteContainer(
          //           text:
          //               widget.hideTransferValue! ? "?" : beautifyTransferValue(widget.player.currentMarketValue!),
          //         ),
          //       if (widget.player.position != null) _RoundedWhiteContainer(text: widget.player.position!),
          //     ],
          //   ),
          // ),
          // DecoratedBox(
          //   decoration: BoxDecoration(color: Colors.white),
          //   child: SizedBox(
          //     width: mq.size.width,
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             widget.player.name + "fkdfkd",
          //             textAlign: TextAlign.center,
          //             style: const TextStyle(
          //               fontSize: 14,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          //   ],
          // ),
          // ),
        ],
      ),
    );

    if (widget.enableFlip) {
      return Stack(
        children: [
          GestureDetector(
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
          ),
          if (widget.count > 1)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  final confirmed = await showModalBottomSheet<bool>(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 16),
                            Text(
                              "Convert dublicate to QR code for your friend? Dublicate will be deleted from your collection",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      context.pop(false);
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: FilledButton(
                                    onPressed: () {
                                      context.pop(true);
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: mq.padding.bottom + 16),
                          ],
                        ),
                      );
                    },
                  );

                  if (confirmed == true) {
                    getIt.get<SavedPlayersBloc>().add(SavedPlayersEventRemove(playerId: widget.player.id));
                    await showModalBottomSheet<bool>(
                      context: context,
                      builder: (context) {
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
                      },
                    );
                  }
                },
                child: Container(
                  height: 64,
                  width: 64,
                  color: Colors.transparent,
                ),
              ),
            ),
        ],
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
            children: [
              if (parseCustomDate(player.birthDate) != null)
                _RoundedWhiteContainer(text: parseCustomDate(player.birthDate)!),
              const Spacer(),
              if (player.foot != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("foot:  "),
                    _RoundedWhiteContainer(text: player.foot!),
                  ],
                ),
              const Spacer(),
              if (player.height != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("height:  "),
                    _RoundedWhiteContainer(text: player.height!),
                  ],
                ),
              const Spacer(),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("current:  "),
                    _RoundedWhiteContainer(text: beautifyTransferValue(player.currentMarketValue!)),
                  ],
                ),
              const Spacer(),
              if (player.currentMarketValue != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("prime:  "),
                    _RoundedWhiteContainer(text: beautifyTransferValue(player.maxMarketValue!)),
                  ],
                ),
              const Spacer(),
              if (player.currentClub != null) _RoundedWhiteContainer(text: player.currentClub!.toUpperCase()),
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
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
