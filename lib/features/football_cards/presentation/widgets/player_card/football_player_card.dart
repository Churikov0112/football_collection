// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/utils/transfer_value_beautifier.dart';

import '../../../domain/cards/player_card.dart';
import '../../screens/packs_screen/football_players_packs_screen.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

// part 'parts/back_widget.dart';
part 'parts/flag.dart';
part 'parts/price_and_position.dart';
part 'parts/rounded_white_container.dart';

class FootballPlayerCardWidget extends StatelessWidget {
  const FootballPlayerCardWidget({
    required this.player,
    required this.badge,
    this.marketValueVisibility = CardElementVisibility.show,
    this.nationalTeamVisibility = CardElementVisibility.show,
    this.nameVisibility = CardElementVisibility.show,
    this.positionVisibility = CardElementVisibility.show,
    this.numberVisibility = CardElementVisibility.show,
    this.clubVisibility = CardElementVisibility.show,
    this.onTap,
    this.onSell,
    this.onSellAll,
    this.onShare,
    this.height = packHeight,
    this.width = packWidth,
    super.key,
  });

  final FootballPlayerCardModel player;
  final CardBadge badge;
  final CardElementVisibility marketValueVisibility;
  final CardElementVisibility nationalTeamVisibility;
  final CardElementVisibility nameVisibility;
  final CardElementVisibility positionVisibility;
  final CardElementVisibility numberVisibility;
  final CardElementVisibility clubVisibility;

  final VoidCallback? onTap;
  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.all(.circular(4)),
          color: Color(0xFF1F5ED3),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(.circular(4)),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF).withValues(alpha: 0.3),
                const Color.fromARGB(0, 255, 255, 255),
                Color(0xFFFFFFFF).withValues(alpha: 0.3),
                // Colors.transparent,
                const Color.fromARGB(0, 255, 255, 255),
                Color(0xFFFFFFFF).withValues(alpha: 0.3),
                Color.fromARGB(84, 8, 12, 86).withValues(alpha: 0.2),
                Color(0xFFFFFFFF).withValues(alpha: 0.3),
              ],
              stops: [0.05, 0.18, 0.3, 0.50, 0.7, 0.85, 1],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Stack(
                  children: [
                    CardImageWrapper(
                      card: player,
                      nationalTeamVisibility: nationalTeamVisibility,
                      marketValueVisibility: marketValueVisibility,
                      numberVisibility: numberVisibility,
                      positionVisibility: positionVisibility,
                      clubVisibility: clubVisibility,
                      badge: badge,
                      onSell: onSell,
                      onSellAll: onSellAll,
                      onShare: onShare,
                      borderRadius: BorderRadius.only(topLeft: .circular(8), bottomRight: .circular(8)),
                    ),
                    // Positioned(
                    //   top: 5,
                    //   left: 5,
                    //   child: _Flag(player: player, nationalTeamVisibility: nationalTeamVisibility),
                    // ),
                    // Positioned(
                    //   bottom: 5,
                    //   right: 5,
                    //   child: _PriceAndPosition(player: player, marketValueVisibility: marketValueVisibility),
                    // ),
                  ],
                ),
              ),
              // SizedBox(height: 4),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AutoSizeText(
                  nameVisibility == .quest
                      ? "?"
                      : nameVisibility == .show
                      ? player.name.toUpperCase()
                      : "",
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  minFontSize: 12,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(flex: 2),

              // SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
