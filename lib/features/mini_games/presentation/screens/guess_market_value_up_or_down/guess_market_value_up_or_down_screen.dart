import 'dart:math';

import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_collection/di/di.dart';
import 'package:football_collection/features/football_cards/data/football_players_repository.dart';
import 'package:football_collection/features/football_cards/domain/models/market_value_model.dart';
import 'package:football_collection/services/localization/translator.dart';
import 'package:football_collection/services/toast/toast_service.dart';
import 'package:football_collection/ui_kit/widgets/background_image/background_image.dart';
import 'package:football_collection/ui_kit/widgets/glass_button/glass_button.dart';
import 'package:football_collection/ui_kit/widgets/transparent_appbar/transparent_appbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import '../../../../football_cards/presentation/blocs/random_market_value_bloc/random_market_value_bloc.dart';
import '../../../../football_cards/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../../../football_cards/presentation/widgets/player_card/football_player_card.dart';
import '../../blocs/balance_bloc/balance_bloc.dart';
import 'widgets/yandex_ads_banner_mixin.dart';

part 'guess_market_value_up_or_down_screen_presenter.dart';
part 'widgets/guess_options.dart';

class GuessMarketValueUpOrDownScreen extends StatelessWidget {
  const GuessMarketValueUpOrDownScreen({super.key});

  // Вспомогательный метод для получения ВСЕХ валидных точек
  List<FlSpot> getAllValidSpots(List<MarketValueHistoryModel> history) {
    final spots = <FlSpot>[];
    for (int i = 0; i < history.length; i++) {
      final age = history[i].age ?? 0;
      final value = history[i].marketValue ?? 0;

      // Добавляем точку только если есть данные
      if (age != 0 || value != 0) {
        spots.add(FlSpot(age.toDouble(), value.toDouble()));
      }
    }
    return spots;
  }

  // Вспомогательный метод для получения ВСЕХ валидных сегментов
  List<LineChartBarData> getColoredSegmentsForRange(List<FlSpot> spots, int target) {
    final segments = <LineChartBarData>[];
    for (int i = 0; i < spots.length - 1; i++) {
      final value2 = spots[i + 1].y;

      final color = value2 < target
          ? Colors.red
          : value2 > target
          ? Colors.green
          : Colors.grey;
      segments.add(
        LineChartBarData(barWidth: 4, dotData: FlDotData(show: false), color: color, spots: [spots[i], spots[i + 1]]),
      );
    }
    return segments;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocProvider(
      create: (context) => RandomMarketValueBloc(getIt.get()),
      child: GuessMarketValueUpOrDownScreenPresenter(
        child: Builder(
          builder: (context) {
            final presenter = GuessMarketValueUpOrDownScreenPresenter.of(context);

            return Scaffold(
              body: Stack(
                children: [
                  BackgroundImage(),
                  BlocBuilder<RandomMarketValueBloc, RandomMarketValueState>(
                    builder: (context, randomMarketValueState) {
                      if (randomMarketValueState is RandomMarketValueStatePending ||
                          randomMarketValueState is RandomMarketValueStateInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final retryButton = Center(
                        child: GlassButton(
                          onPressed: presenter.loadRandomValue,
                          text: AppGlossary.tryAgain.translate(),
                        ),
                      );

                      if (randomMarketValueState is RandomMarketValueStateFailed) {
                        return retryButton;
                      }

                      final marketValue = randomMarketValueState.value!;
                      final playerId = marketValue.id;
                      final marketValueHistory = marketValue.marketValueHistory;

                      if (marketValueHistory == null || marketValueHistory.length < 2) {
                        return retryButton;
                      }

                      return FutureBuilder(
                        future: getIt.get<CommonFootballRepository>().playersGet(id: playerId),
                        builder: (context, playerSnapshot) {
                          final player = playerSnapshot.data?.firstOrNull;
                          if (playerSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (player == null) {
                            return retryButton;
                          }

                          // НОВАЯ ЛОГИКА: Находим первую запись за год, который был 2 года назад
                          final currentYear = DateTime.now().year;
                          final targetYear = currentYear - 2;

                          final lastVisibleRecord = marketValueHistory.firstWhereOrNull(
                            (e) => DateTime.parse(e.date.toString()).year == targetYear,
                          );

                          if (lastVisibleRecord?.marketValue == null) {
                            return retryButton;
                          }

                          final lastVisibleRecordIndex = marketValueHistory.indexOf(lastVisibleRecord!);

                          final startSpots = getAllValidSpots(
                            marketValueHistory.sublist(0, lastVisibleRecordIndex + 1),
                          );
                          final endSpots = getAllValidSpots(marketValueHistory.sublist(lastVisibleRecordIndex));

                          return DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: mq.padding.top + 64),
                                StreamBuilder<String?>(
                                  stream: presenter.selectedOptionStream$,
                                  builder: (context, selectedOptionSnapshot) {
                                    return Align(
                                      child: Column(
                                        children: [
                                          FootballPlayerCardWidget(
                                            player: player,
                                            badge: .none,
                                            marketValueVisibility: .none,
                                          ),
                                          const SizedBox(height: 12),
                                          Translator(
                                            termin: AppGlossary.age,
                                            builder: (ageValue) => Translator(
                                              termin: AppGlossary.marketValue,
                                              builder: (marketValueValue) => SizedBox(
                                                height:
                                                    mq.size.height -
                                                    packHeight -
                                                    mq.padding.top -
                                                    mq.padding.bottom -
                                                    265,
                                                width: mq.size.width - 32,
                                                child: DecoratedBox(
                                                  decoration: const BoxDecoration(color: Colors.black54),
                                                  child: IgnorePointer(
                                                    child: LineChart(
                                                      duration: Duration(milliseconds: 300),
                                                      LineChartData(
                                                        borderData: FlBorderData(
                                                          border: Border.all(color: Colors.blueAccent, width: 4),
                                                        ),
                                                        lineBarsData: [
                                                          // Историческая часть (всегда серая)
                                                          LineChartBarData(
                                                            spots: startSpots,
                                                            color: Colors.white,
                                                            barWidth: 4,
                                                            dotData: FlDotData(show: false),
                                                          ),
                                                          // Прогнозируемая часть
                                                          if (selectedOptionSnapshot.data != null) ...[
                                                            ...getColoredSegmentsForRange(
                                                              endSpots,
                                                              lastVisibleRecord.marketValue!,
                                                            ),
                                                          ],
                                                        ],
                                                        titlesData: FlTitlesData(
                                                          leftTitles: AxisTitles(
                                                            axisNameWidget: Text(marketValueValue),
                                                            sideTitles: SideTitles(showTitles: false),
                                                          ),
                                                          topTitles: AxisTitles(
                                                            axisNameWidget: Text(ageValue),
                                                            sideTitles: SideTitles(showTitles: false, reservedSize: 22),
                                                          ),

                                                          rightTitles: AxisTitles(
                                                            sideTitles: SideTitles(
                                                              showTitles: true,
                                                              reservedSize: 50,
                                                              minIncluded: false,
                                                              maxIncluded: false,
                                                              // getTitles: (value) {
                                                              //   // Показываем только целые года
                                                              //   return value.toInt().toString();
                                                              // },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                Translator(
                                  termin: AppGlossary.up,
                                  builder: (upValue) => Translator(
                                    termin: AppGlossary.down,
                                    builder: (downValue) => Translator(
                                      termin: AppGlossary.equal,
                                      builder: (equalValue) {
                                        final lastValue = marketValueHistory.last.marketValue!;
                                        final lastVisibleValue = lastVisibleRecord.marketValue!;
                                        final rightAnswer = lastValue > lastVisibleValue
                                            ? upValue
                                            : lastValue < lastVisibleValue
                                            ? downValue
                                            : equalValue;
                                        return _GuessOptions(
                                          options: [downValue, equalValue, upValue],
                                          rightAnswer: rightAnswer,
                                          // Передаем дополнительную информацию для отображения
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                StreamBuilder<bool>(
                                  stream: presenter.isBannerAlreadyCreatedStream$,
                                  builder: (context, isBannerAlreadyCreatedSnapshot) {
                                    if (isBannerAlreadyCreatedSnapshot.data != true) return const SizedBox(height: 100);
                                    return SizedBox(height: 100, child: AdWidget(bannerAd: presenter.banner));
                                  },
                                ),
                                SizedBox(height: mq.padding.bottom),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Translator(
                    termin: AppGlossary.marketValueUpOrDown,
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
