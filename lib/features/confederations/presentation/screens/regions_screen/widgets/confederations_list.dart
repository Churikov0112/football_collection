part of '../confederations_screen.dart';

class _RegionsList extends StatelessWidget {
  const _RegionsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfederationsBloc, ConfederationsState>(
      bloc: getIt.get(),
      builder: (context, regionsState) {
        final confederations = regionsState.confederations ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: confederations.length,
            itemBuilder: (context, index) {
              return _RegionTile(
                confederation: confederations[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _RegionTile extends StatelessWidget {
  const _RegionTile({
    required this.confederation,
  });

  final Confederations confederation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllCountriesBloc, AllCountriesState>(
      bloc: getIt.get(),
      builder: (context, allCountriesState) {
        return BlocBuilder<AllPlayersBloc, AllPlayersState>(
          bloc: getIt.get(),
          builder: (context, allPlayersState) {
            return BlocBuilder<SavedPlayersBloc, SavedPlayersState>(
              bloc: getIt.get(),
              builder: (context, savedPlayersState) {
                final savedPlayerIds = savedPlayersState.savedIds ?? [];

                final allPlayers = allPlayersState.allPlayers ?? [];
                final allCountries = allCountriesState.countries ?? [];
                final confederationCountries = allCountries.where((country) => country.confederation == confederation);

                final confederationPlayers = allPlayers.where(
                    (player) => confederationCountries.firstWhereOrNull((cc) => cc.id == player.countryId) != null);
                final savedConfederationPlayers =
                    confederationPlayers.where((player) => savedPlayerIds.contains(player.id));

                final value = savedConfederationPlayers.length / confederationPlayers.length;

                return GestureDetector(
                  onTap: () {
                    context.push(RoutePaths.countries, extra: confederation);
                  },
                  child: SquareProgressIndicator(
                    value: value,
                    width: 100,
                    height: 100,
                    borderRadius: 24,
                    startPosition: StartPosition.topCenter,
                    strokeCap: StrokeCap.square,
                    clockwise: true,
                    color: Colors.greenAccent,
                    emptyStrokeColor: confederation.color,
                    strokeWidth: 4,
                    emptyStrokeWidth: 4,
                    strokeAlign: SquareStrokeAlign.outside,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: confederation.color?.withAlpha(200),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            child: Text(
                              confederation.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Align(
                            child: Text(
                              "${savedConfederationPlayers.length} / ${confederationPlayers.length}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
