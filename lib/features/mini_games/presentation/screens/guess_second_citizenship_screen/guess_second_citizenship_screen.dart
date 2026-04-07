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
import '../../../../football_cards/presentation/blocs/random_football_players_bloc/random_football_players_bloc.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_second_citizenship_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessSecondCitizenshipScreen extends StatelessWidget {
  const GuessSecondCitizenshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballPlayersBloc(getIt.get()),
      child: GuessSecondCitizenshipScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessSecondCitizenshipScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
                    builder: (context, randomPlayersState) {
                      final allPlayers = randomPlayersState.players ?? [];
                      final player = allPlayers.firstOrNull;
                      final secondCitizenship = player?.citizenship?[1];

                      if (secondCitizenship == null) return Align(child: const CircularProgressIndicator());
                      final allWrongCitizenships = allCitizenships.where((e) => e != secondCitizenship).toList();
                      allWrongCitizenships.shuffle();
                      final wrongOptions = allWrongCitizenships.sublist(0, 3);

                      final options = [secondCitizenship, ...wrongOptions];
                      options.shuffle();

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          Align(
                            child: FootballPlayerCardWidget(player: player!, badge: .none),
                          ),
                          const SizedBox(height: 20),
                          _GuessOptions(options: options, rightAnswer: secondCitizenship),
                          const SizedBox(height: 20),
                          StreamBuilder<bool>(
                            stream: presenter.isBannerAlreadyCreatedStream$,
                            builder: (context, isBannerAlreadyCreatedSnapshot) {
                              if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox(height: 100);
                              return SizedBox(
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [AdWidget(bannerAd: presenter.banner)],
                                ),
                              );
                            },
                          ),
                          Container(color: Colors.transparent, height: mq.padding.bottom, width: mq.size.width),
                        ],
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessSecondCitizenship,
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
