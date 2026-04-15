// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
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
              Expanded(
                child: CardImageWrapper(
                  card: emblem,
                  badge: badge,
                  onSell: onSell,
                  onSellAll: onSellAll,
                  onShare: onShare,
                  imagePadding: EdgeInsets.all(8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),
              // SizedBox(height: 4),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 4),
              //   child: AutoSizeText(
              //     emblem.name.toUpperCase(),
              //     maxLines: 2,
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              //     minFontSize: 12,
              //     maxFontSize: 18,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(3),
                child: AutoSizeText(
                  emblem.name.toUpperCase(),
                  maxLines: 2,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  minFontSize: 13,
                  maxFontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
