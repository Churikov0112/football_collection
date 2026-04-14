part of '../cards_grid.dart';

class _FootballTeamEmblemAlbumWidget extends StatelessWidget {
  const _FootballTeamEmblemAlbumWidget({required this.emblem, required this.country});

  final FootballTeamEmblemCardModel emblem;
  final FootballNationalTeamModel country;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return SavedPlayerCard(player: player);

    final absentWidget = Container(
      // color: country.confederation.color?.darken().withAlpha(200),
      color: theme.colorScheme.secondary.darken(0.25).withAlpha(180),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              emblem.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),
            ),
            Icon(Icons.person, size: 64, color: Colors.white54),
            Text(
              "Emblem",
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
          final isCardSaved = savedCardsState.savedCardsIds?.contains(emblem.cardId) ?? false;
          if (isCardSaved) {
            return FootballTeamEmblemCardWidget(emblem: emblem, badge: .showCount);
          }
        }
        return absentWidget;
      },
    );
  }
}
