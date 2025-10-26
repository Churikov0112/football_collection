import 'package:flutter/material.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/di.dart';
import '../../../../features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart';
import '../../../../services/navigation/navigation.dart';
import '../../../../services/toast/toast_service.dart';
import 'parts/yandex_ads_rewarded_mixin.dart';

part 'watch_ad_screen_presenter.dart';

class WatchAdScreen extends StatelessWidget {
  const WatchAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return WatchAdScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = WatchAdScreenPresenter.of(context);

          return DecoratedBox(
            decoration: const BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Text("${"${AppGlossary.watchAd.translate()} ${AppGlossary.toGetMore.translate()}"} 🏆 ?"),
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
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(),
                              color: Colors.white10,
                            ),
                            child: SizedBox(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Icon(Icons.games),
                                    const SizedBox(height: 16),
                                    Text(AppGlossary.miniGames.translate(), textAlign: TextAlign.center),
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
                              ToastService.showToast(
                                title: "${AppGlossary.balanceIncreased.translate()} + 100 🏆",
                                seconds: 2,
                              );
                              context.pop();
                            });
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              border: Border.all(),
                              color: Colors.white10,
                            ),
                            child: SizedBox(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Icon(Icons.play_arrow),
                                    const SizedBox(height: 16),
                                    Text("${AppGlossary.watchAd.translate()}\n + 100 🏆", textAlign: TextAlign.center),
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
                  SizedBox(height: mq.padding.bottom + 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
