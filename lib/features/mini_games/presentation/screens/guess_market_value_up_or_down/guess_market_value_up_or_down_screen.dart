import 'dart:math';

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

  List<LineChartBarData> getColoredSegments(List<MarketValueHistoryModel> history, int startIndex) {
    final segments = <LineChartBarData>[];

    // Защита от выхода за пределы массива
    if (history.isEmpty || startIndex <= 0 || startIndex >= history.length) {
      return segments;
    }

    // Получаем исходное значение с проверкой на null
    final startValue = history[startIndex - 1].marketValue ?? 0;
    final startAge = history[startIndex - 1].age ?? 0;

    if (startValue == 0 && startAge == 0) {
      return segments; // Некорректные данные
    }

    final startSpot = FlSpot(startAge.toDouble(), startValue.toDouble());

    // Точки для текущего сегмента
    final spots = <FlSpot>[startSpot];
    Color? currentColor;

    for (int i = startIndex; i < history.length; i++) {
      // Защита от null и некорректных значений
      final age = history[i].age ?? 0;
      final value = history[i].marketValue ?? 0;

      // Пропускаем точки с нулевыми или некорректными значениями
      if (age == 0 && value == 0 && i > startIndex) {
        continue;
      }

      final currentSpot = FlSpot(age.toDouble(), value.toDouble());

      // Определяем цвет для текущей точки
      Color segmentColor;
      if (i == startIndex) {
        // Это первая точка после исходной
        if (value > startValue) {
          segmentColor = Colors.green;
        } else if (value < startValue) {
          segmentColor = Colors.red;
        } else {
          segmentColor = Colors.grey; // Только для первой точки, если равна
        }
      } else {
        // Для остальных точек: сравниваем с исходной
        if (value > startValue) {
          segmentColor = Colors.green;
        } else {
          segmentColor = Colors.red; // Значения равны исходной или ниже - красный
        }
      }

      // Если цвет меняется, сохраняем предыдущий сегмент
      if (currentColor != null && currentColor != segmentColor) {
        if (spots.length >= 2) {
          segments.add(
            LineChartBarData(
              spots: List.from(spots),
              color: currentColor,
              barWidth: 4,
              dotData: FlDotData(show: false),
            ),
          );
        }
        // Начинаем новый сегмент с последней точки
        final lastSpot = spots.last;
        spots.clear();
        spots.add(lastSpot);
      }

      currentColor = segmentColor;
      spots.add(currentSpot);
    }

    // Добавляем последний сегмент
    if (spots.length >= 2 && currentColor != null) {
      segments.add(LineChartBarData(spots: spots, color: currentColor, barWidth: 4, dotData: FlDotData(show: false)));
    }

    return segments;
  }

  // Вспомогательный метод для получения валидных точек
  List<FlSpot> getValidSpots(List<MarketValueHistoryModel> history, int maxIndex) {
    final spots = <FlSpot>[];
    for (int i = 0; i < maxIndex; i++) {
      final age = history[i].age ?? 0;
      final value = history[i].marketValue ?? 0;

      // Добавляем точку только если есть данные
      if (age != 0 || value != 0) {
        spots.add(FlSpot(age.toDouble(), value.toDouble()));
      }
    }
    return spots;
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
                          onPressed: () {
                            presenter.loadRandomValue();
                          },
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

                      // Выбираем только такие пары, где значения НЕ равны
                      final validIndices = <int>[];
                      for (int i = 0; i < marketValueHistory.length - 1; i++) {
                        final currentValue = marketValueHistory[i].marketValue;
                        final nextValue = marketValueHistory[i + 1].marketValue;
                        if (currentValue != nextValue && currentValue != 0 && nextValue != 0 && i > 1) {
                          validIndices.add(i);
                        }
                      }

                      // Если нет валидных индексов, показываем сообщение
                      if (validIndices.isEmpty) {
                        return retryButton;
                      }

                      final random = presenter.random;
                      final randomHistoryIndex = validIndices[random.nextInt(validIndices.length)];
                      final radnomMarketValue = marketValueHistory[randomHistoryIndex];
                      final nextMarketValue = marketValueHistory[randomHistoryIndex + 1];

                      return FutureBuilder(
                        future: getIt.get<CommonFootballRepository>().playersGet(id: playerId),
                        builder: (context, playerSnapshot) {
                          final player = playerSnapshot.data?.firstOrNull;
                          if (player == null) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          // Получаем валидные точки для белой линии
                          final whiteLineSpots = getValidSpots(marketValueHistory, randomHistoryIndex);

                          if (whiteLineSpots.length < 2) {
                            return retryButton;
                          }

                          return DecoratedBox(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                const Spacer(),
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
                                                    240,
                                                width: mq.size.width * 0.8,
                                                child: LineChart(
                                                  LineChartData(
                                                    backgroundColor: Colors.black26,
                                                    borderData: FlBorderData(
                                                      border: Border.all(color: Colors.blueAccent, width: 4),
                                                    ),
                                                    lineBarsData: [
                                                      LineChartBarData(
                                                        spots: whiteLineSpots,
                                                        color: Colors.white,
                                                        barWidth: 4,
                                                        dotData: FlDotData(show: false),
                                                      ),
                                                      if (selectedOptionSnapshot.data != null) ...[
                                                        ...getColoredSegments(marketValueHistory, randomHistoryIndex),
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
                                                    ),
                                                    // Добавляем минимальные и максимальные значения для осей
                                                    // minX: 0,
                                                    // maxX: 50, // Максимальный возраст футболиста
                                                    // minY: 0,
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
                                const SizedBox(height: 4),
                                Translator(
                                  termin: AppGlossary.up,
                                  builder: (upValue) => Translator(
                                    termin: AppGlossary.down,
                                    builder: (downValue) => Translator(
                                      termin: AppGlossary.equal,
                                      builder: (equalValue) => _GuessOptions(
                                        options: [downValue, equalValue, upValue],
                                        rightAnswer:
                                            (radnomMarketValue.marketValue ?? 0) > (nextMarketValue.marketValue ?? 0)
                                            ? downValue
                                            : (radnomMarketValue.marketValue == nextMarketValue.marketValue)
                                            ? equalValue
                                            : upValue,
                                      ),
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
