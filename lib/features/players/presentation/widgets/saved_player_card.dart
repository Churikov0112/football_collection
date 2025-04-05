// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';
import 'package:go_router/go_router.dart';

import '../../data/utils.dart';
import '../../domain/models/player.dart';
import '../screens/open_pack_screen/open_pack_screen.dart';

part 'parts/back_widget.dart';
part 'parts/confirm_create_qr_bs.dart';
part 'parts/flag.dart';
part 'parts/player_image.dart';
part 'parts/player_qr_bs.dart';
part 'parts/price.dart';
part 'parts/rounded_white_container.dart';

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
    // final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

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
          Expanded(
            child: Stack(
              children: [
                _PlayerImage(player: widget.player, count: widget.count),
                _Flag(player: widget.player),
                _Price(player: widget.player, hideTransferValue: widget.hideTransferValue),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.player.name.toUpperCase(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                    builder: (context) => _ConfirmCreateQRBottomSheet(),
                  );

                  if (confirmed == true && mounted) {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => _PlayerQrBottomSheet(),
                    ).timeout(
                      const Duration(milliseconds: 300),
                      onTimeout: () async {
                        getIt.get<SavedPlayersBloc>().add(SavedPlayersEventRemove(playerId: widget.player.id));
                        return true;
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
