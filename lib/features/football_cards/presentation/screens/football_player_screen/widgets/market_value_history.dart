part of '../football_player_screen.dart';

class _MarketValueHistory extends StatelessWidget {
  const _MarketValueHistory({
    required this.player,
    required this.hide,
  });

  final FootballPlayerCardModel player;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    if (hide) {
      return const SizedBox.shrink();
    }

    return FutureBuilder(
      future: getIt.get<MarketValuesRepository>().marketValueGet(player.playerId),
      builder: (context, mvSnapshot) {
        if (mvSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final spots =
            mvSnapshot.data?.marketValueHistory
                ?.map(
                  (e) => (e.age != null && e.marketValue != null)
                      ? FlSpot(e.age!.toDouble(), e.marketValue!.toDouble())
                      : null,
                )
                .nonNulls
                .toList() ??
            [];

        if (spots.isEmpty) {
          return const Center(child: Text("Нет данных"));
        }

        return Translator(
          termin: AppGlossary.age,
          builder: (ageValue) => Translator(
            termin: AppGlossary.marketValue,
            builder: (marketValueValue) => SizedBox(
              width: mq.size.width,
              height: 250,
              child: LineChart(
                duration: const Duration(milliseconds: 300),
                LineChartData(
                  borderData: FlBorderData(
                    border: Border.all(color: Colors.blueAccent, width: 4),
                  ),
                  lineBarsData: [
                    // Историческая часть (всегда серая)
                    LineChartBarData(
                      spots: spots,
                      color: Colors.white,
                      barWidth: 4,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      axisNameWidget: Text(marketValueValue),
                      sideTitles: const SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      axisNameWidget: Text(ageValue),
                      sideTitles: const SideTitles(
                        showTitles: false,
                        reservedSize: 22,
                      ),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 50,
                        minIncluded: true,
                        maxIncluded: true,
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
        );
      },
    );
  }
}
