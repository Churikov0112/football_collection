// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/draft/domain/models/ratings.dart';
import 'package:football_collection/features/draft/domain/models/role.dart';

import '../../../../../../../abstract/presentation/blocs/utils/ratings.dart';
import '../../../../../../../countries/domain/models/country.dart';
import '../../../../../../../football_players/domain/models/player.dart';
import '../../../../../../../football_players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import '../../../../../../domain/models/position.dart';

part '../small_player_card/parts/kit_number.dart';
part '../small_player_card/parts/rounded_white_container.dart';
part '../small_player_card/parts/team_logo.dart';

class SmallDraftFootballPlayerCardWidget extends StatelessWidget {
  const SmallDraftFootballPlayerCardWidget({
    required this.player,
    required this.height,
    required this.width,
    super.key,
  });

  final FootballPlayerCardModel player;
  final double height;
  final double width;

  String formatName(String fullName) {
    List<String> parts = fullName.split(' ');
    if (parts.length < 2) return fullName;
    String initials = parts.sublist(0, parts.length - 1).map((part) => '${part[0]}.').join();
    return '$initials ${parts.last}';
  }

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
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white12),
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
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.white12, width: 1),
                                image: DecorationImage(image: AssetImage(player.imageAssetPath), fit: BoxFit.cover),
                              ),
                              child: SizedBox(height: height, width: width),

                              // Image.asset(player.imageAssetPath, fit: BoxFit.cover, width: width, height: height),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: EdgeInsetsGeometry.only(left: width * 0.04, bottom: width * 0.01),
                                child: Text(
                                  emojiFlag ?? '',
                                  style: TextStyle(fontSize: (width * 0.15).round().toDouble()),
                                  // minFontSize: width * 0.025,
                                  // maxFontSize: width * 0.05,
                                ),
                              ),
                            ),
                            Positioned(
                              right: width * 0.02,
                              top: width * 0.02,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: ratingColor(rating.round()),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.01),
                                  child: Text(
                                    rating.round().toString(),
                                    style: TextStyle(
                                      fontSize: (width * 0.1).round().toDouble(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: width * 0.02,
                              top: width * 0.02,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: FootballPlayerAbstractPosition.fromString(player.position)?.role?.color,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: width * 0.01),
                                  child: Text(
                                    FootballPlayerAbstractPosition.fromString(player.position)?.name.toUpperCase() ??
                                        '',
                                    style: TextStyle(
                                      fontSize: (width * 0.1).round().toDouble(),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Expanded(
                        //       child: Image.asset(player.imageAssetPath, fit: BoxFit.cover, width: width - 32),
                        //     ),
                        //     SizedBox(width: 4),
                        //     DecoratedBox(
                        //       decoration: BoxDecoration(color: Colors.transparent),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //           AutoSizeText(
                        //             rating.round().toString(),
                        //             minFontSize: 2,
                        //             maxFontSize: (width * 0.18).roundToDouble(),
                        //             style: TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: ratingColor(rating.round()),
                        //               // fontSize: width * 0.17,
                        //             ),
                        //           ),
                        //           AutoSizeText(
                        //             FootballPlayerAbstractPosition.fromString(player.position)?.name.toUpperCase() ?? '',
                        //             minFontSize: 2,
                        //             maxFontSize: (width * 0.18).roundToDouble(),
                        //             style: const TextStyle(
                        //               // fontSize: width * 0.17,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //           AutoSizeText(
                        //             emojiFlag ?? '',
                        //             minFontSize: 2,
                        //             maxFontSize: (width * 0.18).roundToDouble(),
                        //             style: const TextStyle(
                        //               // fontSize: width * 0.17,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(width: 4),
                        //   ],
                        // ),
                      ),
                      Align(
                        child: AutoSizeText(
                          formatName(player.name), //   player.name.toUpperCase(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 8,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      // if (player.currentClub != null)
                      //   Align(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [_TeamLogoWidget(currentClub: player.currentClub!, size: width)],
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return card;
  }
}
