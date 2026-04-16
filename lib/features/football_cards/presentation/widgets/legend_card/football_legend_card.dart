// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../domain/cards/legend_card.dart';
import '../../screens/packs_screen/football_players_packs_screen.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

// part 'parts/back_widget.dart';

class FootballLegendCardWidget extends StatelessWidget {
  const FootballLegendCardWidget({
    required this.legend,
    required this.badge,
    this.marketValueVisibility = CardElementVisibility.show,
    this.nationalTeamVisibility = CardElementVisibility.show,
    this.nameVisibility = CardElementVisibility.show,
    this.onTap,
    this.onSell,
    this.onSellAll,
    this.onShare,
    this.height = packHeight,
    this.width = packWidth,
    super.key,
  });

  final FootballLegendCardModel legend;
  final CardBadge badge;
  final CardElementVisibility marketValueVisibility;
  final CardElementVisibility nationalTeamVisibility;
  final CardElementVisibility nameVisibility;

  final VoidCallback? onTap;
  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            // borderRadius: BorderRadius.all(.circular(4)),
            color: Color.fromARGB(255, 201, 144, 19),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.all(.circular(4)),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFFFFF).withValues(alpha: 0.3),
                  const Color.fromARGB(0, 255, 255, 255),
                  const Color(0xFFFFFFFF).withValues(alpha: 0.3),
                  // Colors.transparent,
                  const Color.fromARGB(0, 255, 255, 255),
                  const Color(0xFFFFFFFF).withValues(alpha: 0.3),
                  const Color.fromARGB(86, 117, 69, 17).withValues(alpha: 0.3),
                  const Color(0xFFFFFFFF).withValues(alpha: 0.3),
                ],
                stops: const [0.05, 0.18, 0.3, 0.50, 0.7, 0.85, 1],
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
                        card: legend,
                        badge: badge,
                        onSell: onSell,
                        onSellAll: onSellAll,
                        onShare: onShare,
                        nationalTeamVisibility: nationalTeamVisibility,
                        marketValueVisibility: marketValueVisibility,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
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
                // SizedBox(height: 4),
                // SizedBox(height: 3),
                // SizedBox(
                //   height: height * 0.13,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 4),
                //     child: AutoSizeText(
                //       nameVisibility == .quest
                //           ? "?"
                //           : nameVisibility == .show
                //           ? legend.name.toUpperCase()
                //           : "",
                //       maxLines: 2,
                //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                //       minFontSize: 15,
                //       maxFontSize: 18,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: AutoSizeText(
                      nameVisibility == .quest
                          ? "?"
                          : nameVisibility == .show
                          ? legend.name.toUpperCase()
                          : "",
                      maxLines: 2,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      minFontSize: 13,
                      maxFontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
