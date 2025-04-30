// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/presentation/blocs/football_confederation_countries_bloc/football_confederation_countries_bloc.dart';
import 'package:football_collection/features/countries/presentation/blocs/selected_country_bloc/selected_country_bloc.dart';
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
import '../../../../football_confederations/presentation/screens/confederations_screen/widgets/open_packs_screen_button.dart';
import '../../../../football_players/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart';
import '../../../domain/models/country.dart';
import '../../blocs/selected_confederation_bloc/selected_confederation_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'countries_screen_presenter.dart';
part 'widgets/countries_list.dart';

class FootballCountriesScreen extends StatelessWidget {
  const FootballCountriesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<SelectedConfederationBloc, SelectedConfederationState>(
      bloc: getIt.get(),
      builder: (context, selectedConfederationState) {
        final confederation = selectedConfederationState.confederation;
        if (confederation == null) return const SizedBox.shrink();

        return FootballCountriesScreenPresenter(
          confederation: confederation,
          child: Builder(
            builder: (context) {
              final presenter = FootballCountriesScreenPresenter.of(context);

              return Scaffold(
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
                    Positioned(
                      bottom: mq.padding.bottom,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: OpenPacksScreenButton(
                          onPressed: () {
                            context.push(RoutePaths.footballPlayersPacks);
                          },
                        ),
                      ),
                    ),
                    Translator(
                      termin: confederation.continentTermin,
                      builder: (value) => TransparentAppbar(
                        title: value,
                        backgroundColor: confederation.color,
                      ),
                    ),
                    Positioned(
                      bottom: mq.padding.bottom,
                      right: 0,
                      left: 0,
                      child: StreamBuilder<bool>(
                        stream: presenter.isBannerAlreadyCreatedStream$,
                        builder: (context, isBannerAlreadyCreatedSnapshot) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: OpenPacksScreenButton(
                                  onPressed: () {
                                    context.push(RoutePaths.footballPlayersPacks);
                                  },
                                ),
                              ),
                              // if (isBannerAlreadyCreatedSnapshot.data == true)
                              //   AdWidget(
                              //     bannerAd: presenter.banner,
                              //   ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
