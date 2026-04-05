import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../ui_kit/colors/colors.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../countries/domain/models/national_team.dart';
import '../../../../football_confederations/domain/models/football_confederation.dart';
import '../../../domain/cards/coach_card.dart';
import '../../../domain/cards/legend_card.dart';
import '../../../domain/cards/player_card.dart';
import '../../../domain/cards/team_emblem_card.dart';
import '../card_image_wrapper/card_image_wrapper.dart';
import '../coach_card/football_coach_card.dart';
import '../legend_card/football_legend_card.dart';
import '../player_card/football_player_card.dart';
import '../team_emblem_card/football_team_emblem_card.dart';

part 'widgets/football_coach_album_widget.dart';
part 'widgets/football_legend_album_widget.dart';
part 'widgets/football_player_album_widget.dart';
part 'widgets/football_team_emblem_album_widget.dart';

class CardsGrid extends StatelessWidget {
  const CardsGrid({required this.cards, required this.badge, this.newCardsIds, this.padding, super.key})
    : country = null;

  const CardsGrid.album({
    required this.cards,
    required this.country,
    this.badge = CardBadge.showCount,
    this.padding,
    super.key,
  }) : newCardsIds = null;

  const CardsGrid.packResults({required this.cards, required this.newCardsIds, this.padding, super.key})
    : country = null,
      badge = .none;

  final List<CardModel> cards;
  final FootballNationalTeamModel? country;
  final CardBadge badge;
  final EdgeInsetsGeometry? padding;

  final List<String>? newCardsIds;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return GridView.builder(
      physics: BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      padding:
          padding ?? EdgeInsets.only(top: mq.padding.top + 85, left: 20, right: 20, bottom: mq.padding.bottom + 100),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];

        // album
        if (country != null && newCardsIds == null) {
          if (card is FootballPlayerCardModel) {
            return _FootballPlayerAlbumWidget(player: card, country: country!);
          }

          if (card is FootballCoachCardModel) {
            return _FootballCoachAlbumWidget(coach: card, country: country!);
          }

          if (card is FootballLegendCardModel) {
            return _FootballLegendAlbumWidget(legend: card, country: country!);
          }

          if (card is FootballTeamEmblemCardModel) {
            return _FootballTeamEmblemAlbumWidget(emblem: card, country: country!);
          }
        }

        // pack results
        if (country == null && newCardsIds != null) {
          final isNewCard = newCardsIds!.contains(card.cardId);
          if (card is FootballPlayerCardModel) {
            return FootballPlayerCardWidget(player: card, badge: isNewCard ? .showNew : .none);
          }

          if (card is FootballCoachCardModel) {
            return FootballCoachCardWidget(coach: card, badge: isNewCard ? .showNew : .none);
          }

          if (card is FootballLegendCardModel) {
            return FootballLegendCardWidget(legend: card, badge: isNewCard ? .showNew : .none);
          }

          if (card is FootballTeamEmblemCardModel) {
            return FootballTeamEmblemCardWidget(emblem: card, badge: isNewCard ? .showNew : .none);
          }
        }

        // other
        if (card is FootballPlayerCardModel) {
          return FootballPlayerCardWidget(player: card, badge: badge);
        }
        if (card is FootballCoachCardModel) {
          return FootballCoachCardWidget(coach: card, badge: badge);
        }
        if (card is FootballLegendCardModel) {
          return FootballLegendCardWidget(legend: card, badge: badge);
        }
        if (card is FootballTeamEmblemCardModel) {
          return FootballTeamEmblemCardWidget(emblem: card, badge: badge);
        }

        return SizedBox.shrink();
      },
    );
  }
}
