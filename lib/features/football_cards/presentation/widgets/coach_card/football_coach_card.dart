// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/cards/coach_card.dart';
import '../../screens/packs_screen/football_players_packs_screen.dart';
import '../player_card/parts/player_qr_bs.dart';

part 'parts/flag.dart';
part 'parts/player_image.dart';
part 'parts/rounded_white_container.dart';
part 'parts/what_to_do_with_duplicate_bs.dart';

class FootballCoachCard extends StatefulWidget {
  const FootballCoachCard({
    required this.coach,
    required this.count,
    this.hideNationalTeam = false,
    this.hideName = false,
    this.height = packHeight,
    this.width = packWidth,
    this.enableFlip = false,
    this.showNew = false,
    this.onSell,
    this.onShare,
    this.onSellAll,
    super.key,
  });

  final FootballCoachCardModel coach;
  final int count;
  final bool hideNationalTeam;
  final bool hideName;
  final bool enableFlip;
  final bool showNew;
  final VoidCallback? onSell;
  final VoidCallback? onSellAll;
  final VoidCallback? onShare;

  final double height;
  final double width;

  @override
  State<FootballCoachCard> createState() => _FootballCoachCardState();
}

class _FootballCoachCardState extends State<FootballCoachCard> {
  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;

    final card = Container(
      height: widget.height,
      width: widget.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                _PlayerImage(coach: widget.coach, count: widget.count, showNew: widget.showNew),
                _Flag(coach: widget.coach, hideNationalTeam: widget.hideNationalTeam),
                Positioned(bottom: 5, right: 5, child: _RoundedContainer(text: "Coach")),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.hideName ? "?" : widget.coach.name.toUpperCase(),
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );

    if (widget.enableFlip) {
      return Stack(
        children: [
          card,
          if (widget.count > 1)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  final whatToDo = await showModalBottomSheet<_WhatToDoWithDuplicate>(
                    context: context,
                    builder: (context) => _WhatToDoWithDuplicateBottomSheet(),
                  );

                  if (whatToDo == _WhatToDoWithDuplicate.qr && mounted) {
                    widget.onShare?.call();
                    // try {
                    //   await FirebaseAnalytics.instance.logEvent(
                    //     name: "player_to_qr",
                    //     parameters: {
                    //       "player_id": widget.player.playerId,
                    //       "player_country_id": widget.player.teamId.toString(),
                    //       "player_club": widget.player.clubName ?? "no_data",
                    //       "player_position": widget.player.position ?? "no_data",
                    //       "current_current_market_value": widget.player.marketValue ?? "no_data",
                    //       "player_max_market_value": widget.player.maxMarketValue ?? "no_data",
                    //     },
                    //   );
                    // } catch (e) {
                    //   LogService.error(e.toString(), e);
                    // }
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => CardQrBottomSheet(card: widget.coach),
                    ).timeout(
                      const Duration(milliseconds: 300),
                      onTimeout: () async {
                        getIt.get<SavedCardsBloc>().add(SavedCardsEventRemove(cardId: widget.coach.cardId));
                        return true;
                      },
                    );
                  }
                  if (whatToDo == _WhatToDoWithDuplicate.sell && mounted) {
                    widget.onSell?.call();
                    // try {
                    //   await FirebaseAnalytics.instance.logEvent(
                    //     name: "player_sell",
                    //     parameters: {
                    //       "player_id": widget.player.playerId,
                    //       "player_country_id": widget.player.teamId.toString(),
                    //       "player_club": widget.player.clubName ?? "no_data",
                    //       "player_position": widget.player.position ?? "no_data",
                    //       "current_current_market_value": widget.player.marketValue ?? "no_data",
                    //       "player_max_market_value": widget.player.maxMarketValue ?? "no_data",
                    //     },
                    //   );
                    // } catch (e) {
                    //   LogService.error(e.toString(), e);
                    // }
                    getIt.get<SavedCardsBloc>().add(SavedCardsEventRemove(cardId: widget.coach.cardId));
                    getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 1));
                    ToastService.showToast(title: "${AppGlossary.balanceIncreased.translate()} + 1 🏆", seconds: 2);
                  }

                  if (whatToDo == _WhatToDoWithDuplicate.sellAll) {
                    final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? <String>[];
                    final savedCardsIdsSingle = <String>[];
                    final duplicates = <String>[];
                    for (final savedCardId in savedCardsIds) {
                      if (!savedCardsIdsSingle.contains(savedCardId)) {
                        savedCardsIdsSingle.add(savedCardId);
                      } else {
                        duplicates.add(savedCardId);
                      }
                    }
                    // try {
                    //   await FirebaseAnalytics.instance.logEvent(
                    //     name: "player_sellAll",
                    //     parameters: {
                    //       "saved_cards_ids_length": savedCardsIds.length,
                    //       "duplicates_length": duplicates.length,
                    //     },
                    //   );
                    // } catch (e) {
                    //   LogService.error(e.toString(), e);
                    // }
                    getIt.get<SavedCardsBloc>().add(SavedCardsEventRemoveAll(cardIds: duplicates));
                    getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: duplicates.length));
                    ToastService.showToast(
                      title: "${AppGlossary.balanceIncreased.translate()} + ${duplicates.length} 🏆",
                      seconds: 2,
                    );
                    widget.onSellAll?.call();
                  }
                },
                child: Container(height: 64, width: 64, color: Colors.transparent),
              ),
            ),
        ],
      );
    }
    return card;
  }
}
