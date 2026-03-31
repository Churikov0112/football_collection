import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import 'package:football_collection/features/football_cards/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/football_player_card.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import '../../../../leaderboard/presentation/screens/leaderboard_screen/widgets/country_selection_bottom_sheet.dart';
import '../../../domain/models/player.dart';

part 'football_players_duplicates_screen_presenter.dart';
part 'widgets/duplicates_grid.dart';
part 'widgets/filters_sheet.dart';
part 'widgets/sort_sheet.dart';
part 'widgets/top_controls_row.dart';

enum _PositionGroup { all, gk, def, mid, att }

enum _SortOption { nameAsc, nameDesc, countDesc, countAsc, valueDesc, valueAsc }

class FootballPlayersDuplicatesScreen extends StatelessWidget {
  const FootballPlayersDuplicatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FootballPlayersDuplicatesScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = FootballPlayersDuplicatesScreenPresenter.of(context);
          final mq = MediaQuery.of(context);

          return Material(
            child: ValueListenableBuilder(
              valueListenable: presenter.viewState,
              builder: (context, viewState, _) {
                return Stack(
                  children: [
                    const BackgroundImage(),
                    BlocBuilder<AllFootballPlayersBloc, AllFootballPlayersState>(
                      bloc: getIt.get(),
                      builder: (context, allPlayersState) {
                        return BlocBuilder<SavedCardsBloc, SavedCardsState>(
                          bloc: getIt.get(),
                          builder: (context, savedCardsState) {
                            if (allPlayersState is AllFootballPlayersStatePending ||
                                savedCardsState is SavedCardsStatePending) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final allPlayers = allPlayersState.allPlayers ?? const <FootballPlayerCardModel>[];
                            final savedIds = savedCardsState.savedCardsIds ?? const <String>[];

                            return ValueListenableBuilder<TextEditingValue>(
                              valueListenable: presenter.searchController,
                              builder: (context, value, _) {
                                final items = presenter.buildItems(allPlayers, savedIds, viewState, value.text);

                                return _DuplicatesGrid(items: items, bottomPadding: mq.padding.bottom + 16);
                              },
                            );
                          },
                        );
                      },
                    ),

                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Translator(
                        termin: AppGlossary.duplicates,
                        builder: (value) => Column(
                          children: [
                            TransparentAppbar(title: value),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: _TopControlsRow(
                                controller: presenter.searchController,
                                filtersDirty: viewState.filtersDirty,
                                onOpenFilters: presenter.openFiltersSheet,
                                onOpenSort: presenter.openSortSheet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
