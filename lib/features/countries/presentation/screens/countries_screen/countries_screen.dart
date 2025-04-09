// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/presentation/blocs/football_confederation_countries_bloc/football_confederation_countries_bloc.dart';
import 'package:football_collection/features/football_confederations/domain/models/football_confederation.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../../ui_kit/widgets/background_image/background_image_color_filter.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart';
import '../../../../football_players/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../../football_players/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../../domain/models/country.dart';

part 'countries_screen_presenter.dart';
part 'widgets/countries_list.dart';

class FootballCountriesScreen extends StatelessWidget {
  const FootballCountriesScreen({
    required this.confederation,
    super.key,
  });

  final FootballConfederations confederation;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return FootballCountriesScreenPresenter(
      confederation: confederation,
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            BackgroundImageColorFilter(color: confederation.color),
            Column(
              children: [
                _CountriesList(),
              ],
            ),
            Translator(
              termin: confederation.continentTermin,
              builder: (value) => TransparentAppbar(
                title: value,
                backgroundColor: confederation.color,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.footballPlayersPacks,
              extra: FootballPlayersPacksScreenArgs(confederation: confederation),
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
