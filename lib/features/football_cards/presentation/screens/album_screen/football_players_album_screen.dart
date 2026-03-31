// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/features/football_confederations/presentation/screens/confederations_screen/widgets/open_packs_screen_button.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../../ui_kit/widgets/background_image/background_image_color_filter.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../domain/cards/player_card.dart';
import '../../blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../widgets/football_player_card.dart';
import '../packs_screen/football_players_packs_screen.dart';

part 'football_players_album_screen_presenter.dart';
part 'widgets/album_widget.dart';
part 'widgets/players_list.dart';

class FootballPlayersAlbumScreen extends StatelessWidget {
  const FootballPlayersAlbumScreen({required this.country, super.key});

  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return FootballPlayersAlbumScreenPresenter(
      child: Builder(
        builder: (context) {
          // final presenter = FootballPlayersAlbumScreenPresenter.of(context);

          return Scaffold(
            body: Stack(
              children: [
                BackgroundImage(),
                BackgroundImageColorFilter(color: country.confederation.color),
                Column(children: [_FootballPlayersList(country: country)]),
                TransparentAppbar(
                  title: "${emojiFlagByCountryName(country.name) ?? ""}  ${country.name}",
                  // backgroundColor: country.confederation.color,
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
                          extra: FootballPlayersPacksScreenArgs(country: country),
                        );
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
