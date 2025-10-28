// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/draft/domain/models/position.dart';
import 'package:football_collection/features/draft/domain/models/ratings.dart';

import '../../../../../../../../ui_kit/widgets/frosted_glass_container/frosted_glass_container.dart';
import '../../../../../../../abstract/presentation/blocs/utils/ratings.dart';
import '../../../../../../../countries/domain/models/country.dart';
import '../../../../../../../football_players/domain/models/player.dart';
import '../../../../../../../football_players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';

part 'parts/kit_number.dart';
part 'parts/rounded_white_container.dart';
part 'parts/team_logo.dart';

class DraftFootballPlayerCardWidget extends StatelessWidget {
  const DraftFootballPlayerCardWidget({required this.player, required this.height, required this.width, super.key});

  final FootballPlayerCardModel player;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);
    // final imageUrl = player.photoUrl.contains("medium") ? player.photoUrl.replaceAll("medium", "big") : player.photoUrl;
    // final teamPalette = teamPaletteById(player.teamId);
    // final allCompetitions = getIt.get<AllFootballCompetitionsBloc>().state.allCompetitions;
    // final String? playerCompetitionId = allCompetitions?.firstWhereOrNull((c) => c.teamsIds.contains(player.teamId))?.id;

    final rating =
        ratings[player.playerId]?["overall"] ?? 0; // FootballPlayerStatsCalculator.calculateStats(player).rating;
    final allCountries = getIt.get<AllCountriesBloc>().state.countries ?? [];
    final playerCountryName = allCountries.firstWhere((c) => c.id == player.countryId).name;
    final emojiFlag = emojiFlagByCountryName(playerCountryName);

    final card = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white12, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Spacer(),

                    // const Spacer(),
                    // const Spacer(),
                    // const Spacer(),
                    // const Spacer(),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(player.imageAssetPath, fit: BoxFit.cover, width: width - 32),
                          ),
                          SizedBox(width: 4),
                          DecoratedBox(
                            decoration: BoxDecoration(color: Colors.transparent),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AutoSizeText(
                                  rating.round().toString(),
                                  minFontSize: 2,
                                  maxFontSize: (width * 0.18).roundToDouble(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ratingColor(rating.round()),
                                    // fontSize: width * 0.17,
                                  ),
                                ),
                                AutoSizeText(
                                  FootballPlayerAbstractPosition.fromString(player.position)?.name.toUpperCase() ?? '',
                                  minFontSize: 2,
                                  maxFontSize: (width * 0.18).roundToDouble(),
                                  style: const TextStyle(
                                    // fontSize: width * 0.17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AutoSizeText(
                                  emojiFlag ?? '',
                                  minFontSize: 2,
                                  maxFontSize: (width * 0.18).roundToDouble(),
                                  style: const TextStyle(
                                    // fontSize: width * 0.17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ),

                    if (player.currentClub != null)
                      Align(
                        child: _TeamLogoWidget(currentClub: player.currentClub!, size: width),
                      ),
                    // TODO work from here
                    FrostedGlassContainer(
                      // color: Colors.white,
                      // borderRadius: const BorderRadius.all(Radius.circular(12)),
                      blupColor: Colors.white12,
                      child: SizedBox(
                        height: width * 0.15,
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Center(
                            child: AutoSizeText(
                              player.name.toUpperCase(),
                              maxLines: 1,
                              minFontSize: 5,
                              maxFontSize: 10,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // const SizedBox(height: 4),
                    // const Spacer(),
                    // const Spacer(),
                  ],
                ),
              ),
            ),

            // Positioned(
            //   right: width * 0.05,
            //   top: width * 0.02,
            //   child: AutoSizeText(
            //     rating.round().toString(),
            //     minFontSize: 4,
            //     maxFontSize: (width * 0.18).roundToDouble(),
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       color: ratingColor(rating.round()),
            //       // fontSize: width * 0.17,
            //     ),
            //   ),
            // ),
            // Positioned(
            //   right: width * 0.05,
            //   top: width * 0.2,
            //   child: AutoSizeText(
            //     FootballPlayerAbstractPosition.fromString(player.position)?.name.toUpperCase() ?? '',
            //     minFontSize: 4,
            //     maxFontSize: (width * 0.18).roundToDouble(),
            //     style: const TextStyle(
            //       // fontSize: width * 0.17,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
        // ),
      ),
    );

    return card;
  }
}
