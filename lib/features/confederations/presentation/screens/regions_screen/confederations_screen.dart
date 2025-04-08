// ignore_for_file: deprecated_member_use

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import 'package:football_collection/features/players/presentation/blocs/all_players_bloc/all_players_bloc.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../menu/presentation/screens/menu_drawer.dart';
import '../../../../players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../../../players/presentation/screens/open_pack_screen/open_pack_screen.dart';
import '../../blocs/confederations_bloc/confederations_bloc.dart';

part 'confederations_screen_presenter.dart';
part 'widgets/confederations_list.dart';

class ConfederationsScreen extends StatelessWidget {
  const ConfederationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final mq = MediaQuery.of(context);

    return ConfederationsScreenPresenter(
      child: Scaffold(
        drawer: MenuDrawer(),
        body: Stack(
          children: [
            BackgroundImage(),
            Column(
              children: [
                Translator(
                  termin: AppGlossary.continents,
                  builder: (value) => TransparentAppbar(title: value, showDrawer: true),
                ),
                const _RegionsList(),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.stickerpack,
              extra: OpenPackScreenArgs(),
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
