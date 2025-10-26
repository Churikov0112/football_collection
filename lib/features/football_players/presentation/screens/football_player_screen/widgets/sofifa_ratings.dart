part of '../football_player_screen.dart';

class _SofifaRatings extends StatelessWidget {
  const _SofifaRatings({required this.player, this.hide = false});

  final FootballPlayerCardModel player;
  final bool hide;

  @override
  Widget build(BuildContext context) {
    final ratings = FootballPlayerStatsCalculator.calculateStats(player);

    if (ratings == null || hide) {
      return const SizedBox.shrink();
    }

    return Column(
      spacing: 16,
      children: [
        _RatingsBlock(title: null, values: {"Overall": ratings.rating.round()}),
        _RatingsBlock(
          title: "Ratings",
          values: {
            "Defence": ratings.defence.round(),
            "Dribbling": ratings.dribbling.round(),
            "Goalkeeper": ratings.goalkeeper.round(),
            "Low Pass": ratings.lowPass.round(),
            "Max Speed": ratings.maxSpeed.round(),
            "Shoots": ratings.shoots.round(),
          },
        ),
      ],
    );
  }
}

class _RatingsBlock extends StatelessWidget {
  const _RatingsBlock({required this.title, required this.values});

  final String? title;
  final Map<String, int> values;

  @override
  Widget build(BuildContext context) {
    final int average = (values.values.reduce((a, b) => a + b) / values.length).round();

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.white10, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  Text(title!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  RatingTag(value: average),
                ],
              ),
              const SizedBox(height: 8),
              const _Separator(),
              const SizedBox(height: 8),
            ],

            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: values.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) =>
                  const Column(children: [SizedBox(height: 8), _Separator(), SizedBox(height: 8)]),
              // spacing: 8,
              // crossAxisAlignment: CrossAxisAlignment.start,
              itemBuilder: (context, index) {
                final rating = values.entries.elementAt(index);
                return _RatingTile(title: rating.key, value: rating.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingTile extends StatelessWidget {
  const _RatingTile({required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return
    // Column(
    //   children: [
    // const _Separator(),
    // const SizedBox(height: 8),
    Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),
        // const SizedBox(width: 8),
        const Spacer(),
        RatingTag(value: value),
      ],
      //   ),
      // ],
    );
  }
}

class RatingTag extends StatelessWidget {
  const RatingTag({required this.value, this.color, super.key});

  final int value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: ratingColor(value)?.darken(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Center(
          child: Text(value.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
