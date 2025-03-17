import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/regions/domain/models/region.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/regions_bloc/regions_bloc.dart';

part 'regions_screen_presenter.dart';
part 'widgets/regions_list.dart';

class RegionsScreen extends StatelessWidget {
  const RegionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return RegionsScreenPresenter(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Регионы"),
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
      ),
    );
  }
}
