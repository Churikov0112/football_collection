// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/features/players/presentation/blocs/country_players_bloc/country_players_bloc.dart';
import 'package:football_collection/features/players/presentation/screens/open_pack_screen/open_pack_screen.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:go_router/go_router.dart';

import '../../../../../ui_kit/widgets/background_image/background_image_color_filter.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../domain/models/player.dart';
import '../../blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../widgets/saved_player_card.dart';

part 'players_screen_presenter.dart';
part 'widgets/player_card.dart';
part 'widgets/players_list.dart';

class PlayersScreen extends StatelessWidget {
  const PlayersScreen({
    required this.country,
    super.key,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return PlayersScreenPresenter(
      country: country,
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundImage(),
            BackgroundImageColorFilter(color: country.confederation.color),
            Column(children: [const _PlayersList()]),
            TransparentAppbar(
              title: "${emojiFlagByCountryName(country.name) ?? ""}  ${country.name}",
              backgroundColor: country.confederation.color,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.stickerpack,
              extra: OpenPackScreenArgs(country: country),
            );
          },
          label: Text('Open pack'),
          icon: Icon(Icons.style),
        ),
      ),
    );
  }
}
