// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

import '../../../domain/cards/team_emblem_card.dart';
import '../../screens/packs_screen/football_players_packs_screen.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

class FootballTeamEmblemCardWidget extends StatelessWidget {
  const FootballTeamEmblemCardWidget({
    required this.emblem,
    required this.badge,
    this.onTap,
    this.onSell,
    this.onSellAll,
    this.onShare,
    this.height = packHeight,
    this.width = packWidth,
    super.key,
  });

  final FootballTeamEmblemCardModel emblem;
  final CardBadge badge;

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
          color: Color.fromARGB(255, 201, 144, 19),
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
                Color.fromARGB(86, 117, 69, 17).withValues(alpha: 0.3),
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
                      card: emblem,
                      badge: badge,
                      onSell: onSell,
                      onSellAll: onSellAll,
                      onShare: onShare,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                    ),
                    // Positioned(
                    //   top: 5,
                    //   left: 5,
                    //   child: _Flag(legend: legend, nationalTeamVisibility: nationalTeamVisibility),
                    // ),
                    // Positioned(
                    //   bottom: 5,
                    //   right: 5,
                    //   child: _PriceAndPosition(legend: legend, marketValueVisibility: marketValueVisibility),
                    // ),
                  ],
                ),
              ),
              // // SizedBox(height: 4),
              // Spacer(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 4),
              //   child: AutoSizeText(
              //     nameVisibility == .quest
              //         ? "?"
              //         : nameVisibility == .show
              //         ? legend.name.toUpperCase()
              //         : "",
              //     maxLines: 1,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              //     minFontSize: 12,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // Spacer(flex: 2),

              // // SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
