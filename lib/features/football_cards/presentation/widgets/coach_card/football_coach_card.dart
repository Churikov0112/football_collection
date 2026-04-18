// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/football_cards/presentation/screens/packs_screen/football_players_packs_screen.dart';

import '../../../domain/cards/coach_card.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

class FootballCoachCardWidget extends StatelessWidget {
  const FootballCoachCardWidget({
    required this.coach,
    required this.badge,
    this.nationalTeamVisibility = CardElementVisibility.show,
    this.nameVisibility = CardElementVisibility.show,
    this.onSell,
    this.onShare,
    this.onSellAll,
    this.onTap,
    this.height = packHeight,
    this.width = packWidth,
    super.key,
  });

  final FootballCoachCardModel coach;
  final CardBadge badge;

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
            color: Color(0xFF1F5ED3),
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
                  const Color.fromARGB(84, 8, 12, 86).withValues(alpha: 0.2),
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
                        card: coach,
                        badge: badge,
                        onSell: onSell,
                        onSellAll: onSellAll,
                        onShare: onShare,
                        nationalTeamVisibility: nationalTeamVisibility,
                        borderRadius: const .only(topLeft: .circular(8), bottomRight: .circular(8)),
                      ),

                      // Positioned(
                      //   top: 5,
                      //   left: 5,
                      //   child: _Flag(
                      //     imageAssetPath: 'assets/raster/teams_flags/${coach.teamId}.jpg',
                      //     nationalTeamVisibility: nationalTeamVisibility,
                      //   ),
                      // ),
                      // Positioned(bottom: 5, right: 5, child: _RoundedContainer(text: "Coach")),
                    ],
                  ),
                ),
                // SizedBox(height: 3),
                // SizedBox(
                //   height: height * 0.13,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 4),
                //     child: AutoSizeText(
                //       nameVisibility == .quest
                //           ? "?"
                //           : nameVisibility == .show
                //           ? coach.name.toUpperCase()
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
                          ? coach.name.toUpperCase()
                          : "",
                      maxLines: 2,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      minFontSize: 13,
                      maxFontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
