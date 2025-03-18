import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(RoutePaths.stickerpack);
          },
          child: Icon(Icons.style),
        ),
      ),
    );
  }
}
