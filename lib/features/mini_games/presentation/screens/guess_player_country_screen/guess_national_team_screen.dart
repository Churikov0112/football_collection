import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/data/football_players_repository.dart';
import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_national_team_presenter.dart';
part 'widgets/guess_options.dart';

class GuessNationalTeamScreen extends StatelessWidget {
  const GuessNationalTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final repo = getIt.get<CommonFootballRepository>();

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessNationalTeamScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessNationalTeamScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  FutureBuilder<List<FootballNationalTeamModel>>(
                    future: repo.teamsGet(),
                    builder: (context, allCountriesState) =>
                        BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
                          builder: (context, randomPlayersState) {
                            final player = randomPlayersState.players?.firstOrNull;
                            final allCountries = allCountriesState.data ?? [];
                            final playerCountry = allCountries.firstWhereOrNull((e) => e.id == player?.teamId);

                            if (player == null || playerCountry == null) {
                              return Align(child: const CircularProgressIndicator());
                            }

                            final options = <FootballNationalTeamModel>[];
                            options.add(playerCountry);
                            while (options.length < 4) {
                              final randomCountry = allCountries[presenter.random.nextInt(allCountries.length)];
                              if (options.contains(randomCountry)) continue;
                              options.add(randomCountry);
                            }
                            options.shuffle();

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                StreamBuilder<FootballNationalTeamModel?>(
                                  stream: presenter.selectedOptionStream$,
                                  builder: (context, selectedOptionSnapshot) {
                                    final showResult = selectedOptionSnapshot.data != null;
                                    return Align(
                                      child: FootballPlayerCardWidget(
                                        player: player,
                                        badge: .none,
                                        nationalTeamVisibility: showResult ? .show : .quest,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                _GuessOptions(options: options, rightAnswer: playerCountry),
                                const SizedBox(height: 20),
                                StreamBuilder<bool>(
                                  stream: presenter.isBannerAlreadyCreatedStream$,
                                  builder: (context, isBannerAlreadyCreatedSnapshot) {
                                    if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox(height: 100);
                                    return SizedBox(height: 100, child: AdWidget(bannerAd: presenter.banner));
                                  },
                                ),
                                SizedBox(height: mq.padding.bottom),
                              ],
                            );
                          },
                        ),
                  ),
                  Translator(
                    termin: AppGlossary.guessPlayerTeam,
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
