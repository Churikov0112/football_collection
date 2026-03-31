import 'package:flutter/material.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/football_player_card.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/glass_button/glass_button.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/cards/player_card.dart';

class FootballPlayersPackResultsScreenArgs {
  final List<FootballPlayerCardModel> cards;
  final Set<String> newCardIds;
  final String packName;
  const FootballPlayersPackResultsScreenArgs({required this.packName, required this.cards, required this.newCardIds});
}

class FootballPlayersPackResultsScreen extends StatelessWidget {
  const FootballPlayersPackResultsScreen({required this.args, super.key});

  final FootballPlayersPackResultsScreenArgs args;

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
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  padding: EdgeInsets.only(
                    top: mq.padding.top + 85,
                    left: 20,
                    right: 20,
                    bottom: mq.padding.bottom + 100,
                  ),
                  itemCount: args.cards.length,
                  itemBuilder: (context, index) {
                    final player = args.cards[index];
                    return FootballPlayerCard(
                      player: player,
                      count: 1,
                      enableFlip: true,
                      showNew: args.newCardIds.contains(player.cardId),
                    );
                  },
                ),
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
