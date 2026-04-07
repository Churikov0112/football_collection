import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_cards/presentation/widgets/cards_grid/cards_grid.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/bottom_sheet_controller/bottom_sheet_controller.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';

import '../../../../abstract/domain/models/card.dart';
import '../../../../leaderboard/presentation/screens/leaderboard_screen/widgets/country_selection_bottom_sheet.dart';
import '../../../data/football_players_repository.dart';
import '../../widgets/card_image_wrapper/card_image_wrapper.dart';

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
    final repo = getIt.get<CommonFootballRepository>();

    return FootballPlayersDuplicatesScreenPresenter(
      child: Builder(
        builder: (context) {
          final presenter = FootballPlayersDuplicatesScreenPresenter.of(context);

          return FutureBuilder<List<CardModel>>(
            future: repo.getCards(cardTypes: CardType.values.toSet()),
            builder: (context, allFootballCardsState) {
              return Material(
                child: ValueListenableBuilder(
                  valueListenable: presenter.searchController,
                  builder: (context, searchState, _) {
                    return Stack(
                      children: [
                        const BackgroundImage(),
                        BlocBuilder<SavedCardsBloc, SavedCardsState>(
                          bloc: getIt.get(),
                          builder: (context, savedCardsState) {
                            if (allFootballCardsState.connectionState == .waiting ||
                                savedCardsState is SavedCardsStatePending) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            final allCards = allFootballCardsState.data ?? const <CardModel>[];
                            final savedIds = savedCardsState.savedCardsIds ?? const <String>[];

                            final duplicates = <CardModel>[];

                            for (final card in allCards) {
                              int count = 0;

                              for (final savedId in savedIds) {
                                if (card.cardId == savedId) {
                                  count++;
                                }
                              }

                              if (count > 1) {
                                duplicates.add(card);
                              }
                            }

                            final filteredDuplicates = duplicates
                                .where((c) => c.name.toLowerCase().contains(searchState.text.toLowerCase()))
                                .toList();

                            return ValueListenableBuilder<TextEditingValue>(
                              valueListenable: presenter.searchController,
                              builder: (context, value, _) {
                                return _DuplicatesGrid(cards: filteredDuplicates);
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
          );
        },
      ),
    );
  }
}
