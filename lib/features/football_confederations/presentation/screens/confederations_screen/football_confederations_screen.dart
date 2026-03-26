// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../football_players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import '../../../../football_players/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../../football_players/domain/models/player.dart';
import '../../../../football_players/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../../../menu/presentation/screens/drawer/menu_drawer.dart';
import '../../blocs/football_confederations_bloc/football_confederations_bloc.dart';
import 'widgets/open_packs_screen_button.dart';
import '../../../../countries/domain/models/national_team.dart';

part 'football_confederations_screen_presenter.dart';
part 'widgets/confederations_list.dart';

class FootballConfederationsScreen extends StatelessWidget {
  const FootballConfederationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return FootballConfederationsScreenPresenter(
      child: Builder(
        builder: (context) {
          // final presenter = FootballConfederationsScreenPresenter.of(context);

          return Scaffold(
            drawer: MenuDrawer(),
            body: Stack(
              children: [
                BackgroundImage(),
                Column(
                  children: [
                    BlocBuilder<AllFootballPlayersBloc, AllFootballPlayersState>(
                      bloc: getIt.get(),
                      builder: (context, allPlayersState) {
                        return BlocBuilder<AllCountriesBloc, AllCountriesState>(
                          bloc: getIt.get(),
                          builder: (context, allCountriesState) {
                            final allCountries = allCountriesState.countries ?? [];
                            final allPlayers = allPlayersState.allPlayers ?? [];
                            if (allCountries.isEmpty || allPlayers.isEmpty) return const LinearProgressIndicator();
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
