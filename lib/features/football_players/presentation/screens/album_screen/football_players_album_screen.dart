// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../../services/localization/translator.dart';
import '../../../../../ui_kit/widgets/background_image/background_image_color_filter.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../domain/models/player.dart';
import '../../blocs/country_football_players_bloc/country_football_players_bloc.dart';
import '../../widgets/football_player_card.dart';
import '../packs_screen/football_players_packs_screen.dart';

part 'football_players_album_screen_presenter.dart';
part 'widgets/album_widget.dart';
part 'widgets/players_list.dart';

class FootballPlayersAlbumScreen extends StatelessWidget {
  const FootballPlayersAlbumScreen({
    required this.country,
    super.key,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return FootballPlayersAlbumScreenPresenter(
      country: country,
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            BackgroundImageColorFilter(color: country.confederation.color),
            Column(children: [const _FootballPlayersList()]),
            TransparentAppbar(
              title: "${emojiFlagByCountryName(country.name) ?? ""}  ${country.name}",
              backgroundColor: country.confederation.color,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.footballPlayersPacks,
              extra: FootballPlayersPacksScreenArgs(country: country),
            );
          },
          label: Translator(
            termin: AppGlossary.openPack,
            builder: (value) => Text(value),
          ),
          icon: Icon(Icons.style),
        ),
      ),
    );
  }
}
