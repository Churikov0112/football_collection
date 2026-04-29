import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/countries/domain/models/national_team.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../../ui_kit/widgets/background_image/background_image.dart';
import '../../../../../ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import '../../../../football_cards/domain/models/club_model.dart';
import '../../../../football_cards/presentation/blocs/random_football_clubs_bloc/random_football_clubs_bloc.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_stadium_by_country_and_seats_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessStadiumByCountryAndSeatsScreen extends StatelessWidget {
  const GuessStadiumByCountryAndSeatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomFootballClubsBloc(getIt.get()),
      child: GuessStadiumByCountryAndSeatsScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessStadiumByCountryAndSeatsScreenPresenter.of(
              context,
            );

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
                      final validClubs = clubs
                          .where(_isClubValidForGame)
                          .cast<FootballClubModel>()
                          .toList();

                      if (validClubs.isEmpty) {
                        return const Align(child: CircularProgressIndicator());
                      }

                      final correctClub = validClubs.first;
                      final correctAnswer = correctClub.stadiumName!;
                      final wrongOptions = <String>[];
                      for (final item in validClubs.skip(1)) {
                        final stadiumName = item.stadiumName!;
                        if (stadiumName == correctAnswer ||
                            wrongOptions.contains(stadiumName)) {
                          continue;
                        }
                        wrongOptions.add(stadiumName);
                        if (wrongOptions.length == 3) break;
                      }

                      if (wrongOptions.length < 3) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          presenter.loadRandomClubs();
                        });
                        return const Align(child: CircularProgressIndicator());
                      }

                      final options = [correctAnswer, ...wrongOptions];
                      options.shuffle(Random(correctClub.id.hashCode));

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
                                  color: const Color(0xFF1F5ED3),
                                  boxShadow: const [
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
                                        const Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        const Color.fromARGB(0, 255, 255, 255),
                                        const Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        const Color.fromARGB(0, 255, 255, 255),
                                        const Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                        const Color.fromARGB(
                                          84,
                                          8,
                                          12,
                                          86,
                                        ).withValues(alpha: 0.2),
                                        const Color(
                                          0xFFFFFFFF,
                                        ).withValues(alpha: 0.3),
                                      ],
                                      stops: const [
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${emojiFlagByCountryName(correctClub.league!.countryName!) ?? ""} ${correctClub.league!.countryName!}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Translator(
                                          termin: AppGlossary.seatsCount,
                                          builder: (value) => Text(
                                            "$value: ${correctClub.stadiumSeats!}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                              if (isBannerAlreadyCreatedSnapshot.data != true) {
                                return const SizedBox(height: 100);
                              }
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
                    termin: AppGlossary.guessStadiumByCountryAndSeats,
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

bool _isClubValidForGame(FootballClubModel club) {
  return club.stadiumName != null &&
      club.stadiumSeats != null &&
      club.league?.countryName != null;
}
