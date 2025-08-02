import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/domain/models/pack.dart';
import 'package:football_collection/features/football_players/presentation/screens/packs_screen/football_players_packs_screen.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:go_router/go_router.dart';

import '../../../../../mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';

class NotEnoghtMoneyBottomSheet extends StatelessWidget {
  const NotEnoghtMoneyBottomSheet({
    required this.pack,
    required this.presenter,
    super.key,
  });

  final PackModel pack;
  final FootballPlayersPacksScreenPresenterState presenter;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(AppGlossary.youHaveNotEnoughMoneyToBuyPack.translate()),
          const SizedBox(height: 20),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.push(RoutePaths.miniGames);
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Icon(Icons.games),
                            const SizedBox(height: 16),
                            Text(
                              AppGlossary.playMiniGames.translate(),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    presenter.showRewardedAd(() {
                      getIt.get<BalanceBloc>().add(BalanceEventIncrease(amount: 100)); // TODO remove this cheat
                      ToastService.showToast(title: "${AppGlossary.balanceIncreased.translate()} + 100 🏆", seconds: 2);
                      context.pop();
                    });
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(),
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Icon(Icons.play_arrow),
                            const SizedBox(height: 16),
                            Text(
                              "${AppGlossary.watchAd.translate()}\n + 100 🏆",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: mq.padding.bottom + 20)
        ],
      ),
    );
  }
}
