// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/features/football_cards/presentation/screens/packs_screen/football_players_packs_screen.dart';
import 'package:football_collection/services/localization/translator.dart';

import '../../../domain/cards/coach_card.dart';
import '../card_image_wrapper/card_image_wrapper.dart';

part 'parts/flag.dart';
part 'parts/rounded_white_container.dart';

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
    return SizedBox(
      height: height,
      width: width,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
        ),
        child: Column(
          children: [
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                children: [
                  CardImageWrapper(
                    card: coach,
                    badge: badge,
                    onSell: onSell,
                    onSellAll: onSellAll,
                    onShare: onShare,
                    child: Image.asset(coach.imageAssetPath, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: _Flag(
                      imageAssetPath: 'assets/raster/team_flags/${coach.teamId}.jpg',
                      nationalTeamVisibility: nationalTeamVisibility,
                    ),
                  ),
                  Positioned(bottom: 5, right: 5, child: _RoundedContainer(text: "Coach")),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AutoSizeText(
                nameVisibility == .quest
                    ? "?"
                    : nameVisibility == .show
                    ? coach.name.toUpperCase()
                    : "",
                maxLines: 1,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
