import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/presentation/blocs/random_football_clubs_bloc/random_football_clubs_bloc.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_club_by_stadium_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessClubByStadiumScreen extends StatelessWidget {
  const GuessClubByStadiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballClubsBloc(getIt.get()),
      child: GuessClubByStadiumScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessClubByStadiumScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<
                    RandomFootballClubsBloc,
                    RandomFootballClubsState
                  >(
                    builder: (context, randomFootballClubsState) {
                      final clubs = randomFootballClubsState.value ?? [];

                      if (clubs.firstOrNull?.stadiumName == null) {
                        return Align(child: const CircularProgressIndicator());
                      }

                      final correctAnswer = clubs.first.name;
                      final wrongOptions = <String>[];
                      for (final item in clubs) {
                        if (!wrongOptions.contains(item.name) &&
                            item.name != correctAnswer) {
                          wrongOptions.add(item.name);
                        }
                      }

                      final options = [correctAnswer, ...wrongOptions];
                      options.shuffle(Random(clubs.first.id.hashCode));

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(flex: 2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(.circular(8)),
                                  color: Color(0xFF1F5ED3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      .circular(8),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        const Color.fromARGB(0, 255, 255, 255),
                                        Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        // Colors.transparent,
                                        const Color.fromARGB(0, 255, 255, 255),
                                        Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        Color.fromARGB(
                                          84,
                                          8,
                                          12,
                                          86,
                                        ).withValues(alpha: 0.2),
                                        Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                      ],
                                      stops: [
                                        0.05,
                                        0.18,
                                        0.3,
                                        0.50,
                                        0.7,
                                        0.85,
                                        1,
                                      ],
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    child: Text(
                                      clubs.first.stadiumName ?? '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Spacer(),
                          _GuessOptions(
                            options: options,
                            rightAnswer: correctAnswer,
                          ),
                          const SizedBox(height: 20),
                          StreamBuilder<bool>(
                            stream: presenter.isBannerAlreadyCreatedStream$,
                            builder: (context, isBannerAlreadyCreatedSnapshot) {
                              if (isBannerAlreadyCreatedSnapshot.data != true)
                                return const SizedBox(height: 100);
                              return SizedBox(
                                height: 100,
                                child: AdWidget(bannerAd: presenter.banner),
                              );
                            },
                          ),
                          SizedBox(height: mq.padding.bottom),
                        ],
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.guessClubByStadium,
                    builder: (value) => TransparentAppbar(title: value),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
