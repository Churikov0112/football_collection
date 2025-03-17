import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/presentation/blocs/countries_bloc/countries_bloc.dart';
import 'package:football_collection/features/regions/domain/models/region.dart';
import 'package:football_collection/services/navigation/navigation.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/country.dart';

part 'countries_screen_presenter.dart';
part 'widgets/countries_list.dart';

class CountriesScreen extends StatelessWidget {
  const CountriesScreen({
    required this.region,
    super.key,
  });

  final RegionModel region;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return CountriesScreenPresenter(
      region: region,
      child: Scaffold(
        appBar: AppBar(
          title: Text(region.name),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              _CountriesList(),
            ],
          ),
        ),
      ),
    );
  }
}
