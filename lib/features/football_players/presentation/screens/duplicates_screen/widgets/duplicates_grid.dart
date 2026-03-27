part of '../football_players_duplicates_screen.dart';

class _DuplicatesGrid extends StatelessWidget {
  const _DuplicatesGrid({required this.items, required this.bottomPadding});

  final List<_DuplicateItem> items;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Translator(
          termin: AppGlossary.noDuplicates,
          builder: (value) => Text(value, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ),
      );
    }

    final mq = MediaQuery.of(context);

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.only(top: mq.padding.top + 160, left: 16, right: 16, bottom: bottomPadding),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return FootballPlayerCard(player: item.player, count: item.count, enableFlip: true);
      },
    );
  }
}
