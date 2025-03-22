part of '../countries_screen.dart';

class _CountriesList extends StatelessWidget {
  const _CountriesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      bloc: getIt.get(),
      builder: (context, countriesState) {
        final countries = countriesState.countries ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return _CountryTile(
                country: countries[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPlayersBloc, SavedPlayersState>(
      bloc: getIt.get(),
      builder: (context, savedPlayersState) {
        final savedPlayerIds = savedPlayersState.savedIds ?? [];
        double value = 0;

        final allPlayers = getIt.get<PlayersRepository>().allPlayersCache;
        final countryPlayers = allPlayers.where((player) => player.countryId == country.id);
        final savedCountryPlayers = countryPlayers.where((player) => savedPlayerIds.contains(player.id));
        value = savedCountryPlayers.length / countryPlayers.length;

        return GestureDetector(
          onTap: () {
            context.push(RoutePaths.album, extra: country);
          },
          child: SquareProgressIndicator(
            value: value,
            width: 100,
            height: 100,
            borderRadius: 20,
            startPosition: StartPosition.topCenter,
            strokeCap: StrokeCap.square,
            clockwise: true,
            color: Colors.greenAccent,
            emptyStrokeColor: Colors.black12,
            strokeWidth: 8,
            emptyStrokeWidth: 8,
            strokeAlign: SquareStrokeAlign.center,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: country.confederation.color?.darken(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    child: Text(
                      country.emojiFlag ?? "🏴‍☠️",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                  Align(
                    child: Text(
                      country.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Align(
                    child: Text(
                      "${savedCountryPlayers.length} / ${countryPlayers.length}",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),

                  // Text(country.confederation.name),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
