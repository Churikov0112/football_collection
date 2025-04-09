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

  Future<({double progress, int savedCount, int totalCount})> _calculateProgress(List<String> savedPlayerIds) async {
    await Future.delayed(Duration.zero); // Даем возможность обновить UI
    final allPlayers = getIt.get<AllPlayersBloc>().state.allPlayers ?? [];
    final allCountries = getIt.get<AllCountriesBloc>().state.countries ?? [];
    final confederationCountries = allCountries.where((c) => c.confederation == confederation).toList();
    final confederationPlayers =
        allPlayers.where((player) => confederationCountries.any((cc) => cc.id == player.countryId)).toList();
    final savedCount = confederationPlayers.where((p) => savedPlayerIds.contains(p.id)).length;
    final totalCount = confederationPlayers.length;
    final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;
    return (progress: progress, savedCount: savedCount, totalCount: totalCount);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPlayersBloc, SavedPlayersState>(
      bloc: getIt.get<SavedPlayersBloc>(),
      builder: (context, savedState) {
        final savedPlayerIds = savedState.savedIds ?? [];

        return FutureBuilder<({double progress, int savedCount, int totalCount})>(
          future: _calculateProgress(savedPlayerIds),
          builder: (context, snapshot) {
            final isLoading = snapshot.connectionState == ConnectionState.waiting;
            final progress = isLoading ? 0.0 : snapshot.data?.progress ?? 0.0;
            final savedCount = isLoading ? 0 : snapshot.data?.savedCount ?? 0;
            final totalCount = isLoading ? 0 : snapshot.data?.totalCount ?? 0;

            return GestureDetector(
              onTap: () => context.push(RoutePaths.countries, extra: confederation),
              child: SquareProgressIndicator(
                value: progress,
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
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: confederation.color?.withAlpha(200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          child: Translator(
                            termin: confederation.continentTermin,
                            builder: (value) => Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            isLoading || totalCount == 0 ? "" : "$savedCount / $totalCount",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
