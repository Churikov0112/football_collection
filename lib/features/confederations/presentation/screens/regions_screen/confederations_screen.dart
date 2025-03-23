import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/albums/presentation/blocs/all_countries_bloc/all_countries_bloc.dart';
import 'package:football_collection/features/albums/presentation/blocs/all_players_bloc/all_players_bloc.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../../../albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart';
import '../../../../albums/presentation/screens/sticker_pack_screen/sticker_pack_screen.dart';
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
        appBar: AppBar(
          title: const Text("Confederations"),
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: const Icon(Icons.language),
          //   ),
          // ],
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              const _RegionsList(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(
              RoutePaths.stickerpack,
              extra: StickerpackScreenArgs(),
            );
          },
          label: Text('Open pack'),
          icon: Icon(Icons.style),
        ),
      ),
    );
  }
}
