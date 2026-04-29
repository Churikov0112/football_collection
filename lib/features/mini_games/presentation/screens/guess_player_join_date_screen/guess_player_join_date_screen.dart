import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/config/ad_config.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';

part 'guess_player_join_date_screen_presenter.dart';
part 'widgets/guess_options.dart';
part 'widgets/yandex_ads_banner_mixin.dart';

class GuessPlayerJoinDateScreen extends StatelessWidget {
  const GuessPlayerJoinDateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessPlayerJoinDateScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessPlayerJoinDateScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<
                    RandomFootballPlayersBloc,
                    RandomFootballPlayersState
                  >(
                    builder: (context, randomPlayersState) {
                      final allPlayers = randomPlayersState.players ?? [];
                      final player = allPlayers.firstOrNull;

                      if (player?.joinedClubOn == null) {
                        return Align(child: const CircularProgressIndicator());
                      }

                      final correctAnswer = _normalizeToMonth(
                        player!.joinedClubOn!,
                      );
                      final wrongOptions = <DateTime>[];
                      for (final item in allPlayers) {
                        final joinedClubOn = item.joinedClubOn;
                        if (joinedClubOn == null) {
                          continue;
                        }
                        final normalizedDate = _normalizeToMonth(joinedClubOn);
                        if (normalizedDate == correctAnswer ||
                            wrongOptions.contains(normalizedDate)) {
                          continue;
                        }
                        wrongOptions.add(normalizedDate);
                      }

                      if (wrongOptions.length < 3) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          presenter.loadRandomPlayers();
                        });
                        return Align(child: const CircularProgressIndicator());
                      }

                      final options = [correctAnswer, ...wrongOptions.take(3)];
                      options.shuffle(Random(player.playerId.hashCode));

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Align(
                            child: FootballPlayerCardWidget(
                              player: player,
                              badge: .none,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              player.clubName!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _GuessOptions(
                            options: options,
                            rightAnswer: correctAnswer,
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder<bool>(
                            stream: presenter.isBannerAlreadyCreatedStream$,
                            builder: (context, isBannerAlreadyCreatedSnapshot) {
                              if (isBannerAlreadyCreatedSnapshot.data != true) {
                                return const SizedBox(height: 100);
                              }
                              return SizedBox(
                                height: 100,
                                child: AdWidget(bannerAd: presenter.banner),
                              );
                            },
                          ),
                          SizedBox(height: mq.padding.bottom),
                        ],
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessPlayerJoinDate,
                    builder: (value) => TransparentAppbar(title: value),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

DateTime _normalizeToMonth(DateTime date) => DateTime(date.year, date.month);

String _formatJoinDate(DateTime date) {
  final locale = getIt.get<LanguageBloc>().state.language.toShortString();
  return DateFormat.yMMM(locale).format(date);
}
