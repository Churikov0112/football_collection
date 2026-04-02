// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/football_cards/data/football_players_repository.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../abstract/domain/models/card.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../countries/domain/models/national_team.dart';
import '../../../../football_cards/presentation/screens/packs_screen/football_players_packs_screen.dart';
import 'widgets/open_packs_screen_button.dart';

part 'football_confederations_screen_presenter.dart';
part 'widgets/confederations_list.dart';

class FootballConfederationsScreen extends StatelessWidget {
  const FootballConfederationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final repo = getIt.get<CommonFootballRepository>();

    return FootballConfederationsScreenPresenter(
      child: Builder(
        builder: (context) {
          // final presenter = FootballConfederationsScreenPresenter.of(context);

          return Scaffold(
            // drawer: MenuDrawer(),
            body: Stack(
              children: [
                BackgroundImage(),
                Column(
                  children: [
                    FutureBuilder<List<CardModel>>(
                      future: repo.getAllCards(cardTypes: CardType.values.toSet()),
                      builder: (context, allFootballCardsState) {
                        return FutureBuilder<List<FootballNationalTeamModel>>(
                          future: repo.teamsGet(),
                          builder: (context, allCountriesState) {
                            final allCountries = allCountriesState.data ?? [];
                            final allCards = allFootballCardsState.data ?? [];
                            if (allCountries.isEmpty || allCards.isEmpty) return const LinearProgressIndicator();
                            return const _RegionsList();
                          },
                        );
                      },
                    ),
                  ],
                ),
                Translator(
                  termin: AppGlossary.continents,
                  builder: (value) => TransparentAppbar(title: value),
                ),
                Positioned(
                  bottom: mq.padding.bottom,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: OpenPacksScreenButton(
                      onPressed: () {
                        context.push(RoutePaths.footballPlayersPacks, extra: FootballPlayersPacksScreenArgs());
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
