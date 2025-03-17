import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/blocs/country_players_bloc/country_players_bloc.dart';
import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/player.dart';
import '../../blocs/all_players_bloc/all_players_bloc.dart';
import '../../blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../widgets/player_card_widget.dart';

part 'album_screen_presenter.dart';
part 'widgets/player_card.dart';
part 'widgets/players_list.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({
    required this.country,
    super.key,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return AlbumScreenPresenter(
      country: country,
      child: Scaffold(
        appBar: AppBar(title: Text(country.name)),
        backgroundColor: const Color.fromRGBO(43, 92, 255, 1),
        body: Column(
          children: [
            const _PlayersList(),
          ],
        ),
      ),
    );
  }
}
