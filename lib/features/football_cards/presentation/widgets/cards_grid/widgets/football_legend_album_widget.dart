part of '../cards_grid.dart';

class _FootballLegendAlbumWidget extends StatelessWidget {
  const _FootballLegendAlbumWidget({required this.legend, required this.country});

  final FootballLegendCardModel legend;
  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    // return SavedPlayerCard(player: player);

    final absentWidget = Container(
      // color: country.confederation.color?.darken().withAlpha(200),
      color: Colors.blueAccent.darken(0.3).withAlpha(180),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              legend.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            Icon(Icons.person, size: 64, color: Colors.white54),
            Text(
              "Legend",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
          ],
        ),
      ),
    );

    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get(),
      buildWhen: (previous, current) => current is SavedCardsStateLoadSucceeded,
      builder: (context, savedCardsState) {
        if (savedCardsState is SavedCardsStateLoadSucceeded) {
          final isCardSaved = savedCardsState.savedCardsIds?.contains(legend.cardId) ?? false;
          if (isCardSaved) {
            return FootballLegendCardWidget(legend: legend, badge: .showCount);
          }
        }
        return absentWidget;
      },
    );
  }
}
