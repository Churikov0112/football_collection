import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/player_card/football_player_card.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../../leaderboard/presentation/screens/leaderboard_screen/widgets/country_selection_bottom_sheet.dart';
import '../../../domain/cards/coach_card.dart';
import '../../../domain/cards/player_card.dart';
import '../../blocs/all_football_cards_bloc/all_football_cards_bloc.dart';
import '../../widgets/coach_card/football_coach_card.dart';

part 'football_players_duplicates_screen_presenter.dart';
part 'widgets/duplicates_grid.dart';
part 'widgets/filters_sheet.dart';
part 'widgets/sort_sheet.dart';
part 'widgets/top_controls_row.dart';

enum _PositionGroup { all, gk, def, mid, att }

enum _SortOption { nameAsc, nameDesc, countDesc, countAsc, valueDesc, valueAsc }

class CardsDuplicatesScreen extends StatelessWidget {
  const CardsDuplicatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FootballPlayersDuplicatesScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = FootballPlayersDuplicatesScreenPresenter.of(context);
          final mq = MediaQuery.of(context);

          return Material(
            child: ValueListenableBuilder(
              valueListenable: presenter.searchController,
              builder: (context, searchState, _) {
                return Stack(
                  children: [
                    const BackgroundImage(),
                    BlocBuilder<AllFootballCardsBloc, AllFootballCardsState>(
                      bloc: getIt.get(),
                      builder: (context, allFootballCardsState) {
                        return BlocBuilder<SavedCardsBloc, SavedCardsState>(
                          bloc: getIt.get(),
                          builder: (context, savedCardsState) {
                            if (allFootballCardsState is AllFootballCardsStatePending ||
                                savedCardsState is SavedCardsStatePending) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final allCards = allFootballCardsState.cards ?? const <CardModel>[];
                            final savedIds = savedCardsState.savedCardsIds ?? const <String>[];

                            return ValueListenableBuilder<TextEditingValue>(
                              valueListenable: presenter.searchController,
                              builder: (context, value, _) {
                                final items = presenter.buildItems(allCards, savedIds, value.text);

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
                              child: _TopControlsRow(controller: presenter.searchController),
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
