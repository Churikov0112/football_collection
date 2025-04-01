// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/countries/presentation/blocs/countries_bloc/countries_bloc.dart';
import 'package:football_collection/features/players/data/players_repository.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/colors/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../../../players/presentation/screens/open_pack_screen/open_pack_screen.dart';
import '../../../domain/models/country.dart';

part 'countries_screen_presenter.dart';
part 'widgets/countries_list.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({
    required this.confederation,
    super.key,
  });

  final Confederations confederation;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return CountriesScreenPresenter(
      confederation: confederation,
      child: Scaffold(
        appBar: AppBar(
          title: Text(confederation.name),
          backgroundColor: confederation.color?.darken(),
          foregroundColor: Colors.white,
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: confederation.color?.withOpacity(0.8),
          ),
          child: Column(
            children: [
              _CountriesList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.stickerpack,
              extra: OpenPackScreenArgs(confederation: confederation),
            );
          },
          label: Text('Open pack'),
          icon: Icon(Icons.style),
        ),
      ),
    );
  }
}
