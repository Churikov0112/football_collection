import 'package:flutter/material.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/cards_grid/cards_grid.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/glass_button/glass_button.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';

import '../../../../abstract/domain/models/card.dart';

class FootballCardsPackResultsScreenArgs {
  final List<CardModel> cards;
  final List<String> newCardsIds;
  final String packName;
  const FootballCardsPackResultsScreenArgs({required this.packName, required this.newCardsIds, required this.cards});
}

class FootballCardsPackResultsScreen extends StatelessWidget {
  const FootballCardsPackResultsScreen({required this.args, super.key});

  final FootballCardsPackResultsScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),

          Column(
            children: [
              Expanded(
                child: CardsGrid.packResults(cards: args.cards, newCardsIds: args.newCardsIds),
              ),
            ],
          ),
          Positioned(top: 0, left: 0, right: 0, child: TransparentAppbar(title: args.packName, showBalance: false)),
          Positioned(
            left: 16,
            right: 16,
            bottom: mq.padding.bottom + 16,
            child: GlassButton(onPressed: context.pop, text: AppGlossary.confirm.translate()),
          ),
        ],
      ),
    );
  }
}
