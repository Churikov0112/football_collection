import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../services/localization/translator.dart';
import '../../../../../services/toast/toast_service.dart';
import '../../../../../ui_kit/utils/transfer_value_beautifier.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../domain/cards/coach_card.dart';
import '../../../domain/cards/legend_card.dart';
import '../../../domain/cards/player_card.dart';

part '../duplicate_actions/widgets/card_qr_bs.dart';
part 'widgets/market_value/legend_market_value.dart';
part 'widgets/market_value/player_market_value.dart';
part 'widgets/shildik/coach_shildik.dart';
part 'widgets/shildik/legend_shildik.dart';
part 'widgets/shildik/player_shildik.dart';
part 'widgets/top_left/coach_top_left.dart';
part 'widgets/top_left/legend_top_left.dart';
part 'widgets/top_left/player_top_left.dart';
part 'widgets/top_left/position.dart';

enum CardElementVisibility { none, show, quest }

const _kTopLeftElementSize = 24.0;

class CardImageWrapper extends StatelessWidget {
  const CardImageWrapper({
    required this.card,
    required this.borderRadius,
    this.imagePadding = EdgeInsets.zero,
    this.nationalTeamVisibility,
    this.marketValueVisibility,
    this.numberVisibility,
    this.positionVisibility,
    this.clubVisibility,
    super.key,
  });

  final CardModel card;
  final EdgeInsetsGeometry imagePadding;
  final BorderRadius borderRadius;
  final CardElementVisibility? marketValueVisibility;
  final CardElementVisibility? nationalTeamVisibility;
  final CardElementVisibility? positionVisibility;
  final CardElementVisibility? numberVisibility;
  final CardElementVisibility? clubVisibility;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Padding(
            padding: imagePadding,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset(card.imageAssetPath)]),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: card is FootballPlayerCardModel
                ? _PlayerShildik(
                    player: card as FootballPlayerCardModel,
                    innerBorderRadius: borderRadius.bottomRight,
                    clubVisibility: clubVisibility!,
                  )
                : card is FootballLegendCardModel
                ? _LegendShildik(innerBorderRadius: borderRadius.bottomRight)
                : card is FootballCoachCardModel
                ? _CoachShildik(innerBorderRadius: borderRadius.bottomRight)
                : const SizedBox.shrink(),
          ),

          Positioned(
            top: 0,
            left: 0,
            child: card is FootballPlayerCardModel
                ? _PlayerTopLeft(
                    player: card as FootballPlayerCardModel,
                    nationalTeamVisibility: nationalTeamVisibility!,
                    numberVisibility: numberVisibility!,
                    positionVisibility: positionVisibility!,
                  )
                : card is FootballLegendCardModel
                ? _LegendTopLeft(legend: card as FootballLegendCardModel)
                : card is FootballCoachCardModel
                ? _CoachTopLeft(coach: card as FootballCoachCardModel)
                : const SizedBox.shrink(),
          ),

          if (marketValueVisibility == .show)
            Positioned(
              bottom: 0,
              left: 0,
              child: card is FootballPlayerCardModel
                  ? _PlayerMarketValue(player: card as FootballPlayerCardModel)
                  : card is FootballLegendCardModel
                  ? _LegendMarketValue(legend: card as FootballLegendCardModel)
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
