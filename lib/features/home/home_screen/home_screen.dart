import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' show Scaffold, CircularProgressIndicator, Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../di/di.dart';
import '../../../services/localization/translator.dart';
import '../../../services/log/log_service.dart';
import '../../../services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import '../../../services/navigation/navigation.dart';
import '../../../services/toast/toast_service.dart';
import '../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import '../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../draft/presentation/ui/screens/draft_description_screen/draft_description_screen.dart';
import '../../football_cards/domain/models/player.dart';
import '../../football_cards/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import '../../football_cards/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../football_cards/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../football_confederations/domain/models/football_confederation.dart';
import '../../football_confederations/presentation/blocs/football_confederations_bloc/football_confederations_bloc.dart';
import '../../football_confederations/presentation/screens/confederations_screen/widgets/open_packs_screen_button.dart';
import '../../menu/presentation/screens/drawer/menu_drawer.dart';

part 'home_screen_presenter.dart';
part 'widgets/collection_tile.dart';
part 'widgets/draft_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return HomeScreenPresenter(
      child: Builder(
        builder: (context) {
          return BlocBuilder<AllCountriesBloc, AllCountriesState>(
            bloc: getIt.get(),
            builder: (context, allCountriesState) {
              return BlocBuilder<AllFootballPlayersBloc, AllFootballPlayersState>(
                bloc: getIt.get(),
                builder: (context, allPlayersState) {
                  return BlocBuilder<FootballConfederationsBloc, FootballConfederationsState>(
                    bloc: getIt.get(),
                    builder: (context, allFootballConfederationsState) {
                      final allCompetitions = allFootballConfederationsState.confederations ?? [];
                      final allPlayers = allPlayersState.allPlayers ?? [];
                      final allTeams = allCountriesState.countries ?? [];

                      if (allCompetitions.isEmpty || allTeams.isEmpty || allPlayers.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return Scaffold(
                        drawer: const MenuDrawer(),
                        body: Stack(
                          children: [
                            const BackgroundImage(),
                            Column(
                              spacing: 16,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _CollectionTile(
                                  competitions: allCompetitions,
                                  allPlayers: allPlayers,
                                  showOriginal: true,
                                ),
                                const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: _DraftTile()),
                              ],
                            ),
                            Translator(
                              termin: AppGlossary.menu,
                              builder: (value) => TransparentAppbar(title: value, showDrawer: true),
                            ),
                            Positioned(
                              bottom: mq.padding.bottom,
                              right: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: OpenPacksScreenButton(
                                  onPressed: () {
                                    context.push(
                                      RoutePaths.footballPlayersPacks,
                                      extra: const FootballPlayersPacksScreenArgs(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
