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
import 'package:go_router/go_router.dart';

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
        backgroundColor: country.confederation.color?.lighten(0.05),
        appBar: AppBar(
          backgroundColor: country.confederation.color?.darken(),
          foregroundColor: Colors.white,
          title: Row(
            children: [
              Text(country.name),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.asset(
                  'assets/raster/team_flags/${country.id}.png',
                  height: 36,
                  width: 36,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const _PlayersList(),
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
