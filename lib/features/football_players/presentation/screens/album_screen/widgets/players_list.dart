part of '../football_players_album_screen.dart';

class _FootballPlayersList extends StatelessWidget {
  const _FootballPlayersList();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<CountryFootballPlayersBloc, CountryFootballPlayersState>(
      bloc: getIt.get(),
      builder: (context, countryPlayersState) {
        final players = countryPlayersState.players ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: EdgeInsets.only(top: mq.padding.top + 75, left: 10, right: 10, bottom: 250),
            itemCount: players.length,
            itemBuilder: (context, index) {
              return _FootballPlayerAlbumWidget(
                player: players[index],
                country: countryPlayersState.country!,
              );
            },
          ),
        );
      },
    );
  }
}
