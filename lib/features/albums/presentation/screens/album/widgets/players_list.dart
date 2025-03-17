part of '../album_screen.dart';

class _PlayersList extends StatelessWidget {
  const _PlayersList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryPlayersBloc, CountryPlayersState>(
      bloc: getIt.get(),
      builder: (context, countryPlayersState) {
        final players = countryPlayersState.players ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: players.length,
            itemBuilder: (context, index) {
              return _PlayerCard(
                player: players[index],
              );
            },
          ),
        );
      },
    );
  }
}
