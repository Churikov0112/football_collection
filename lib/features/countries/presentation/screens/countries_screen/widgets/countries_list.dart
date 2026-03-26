part of '../countries_screen.dart';

class _CountriesList extends StatelessWidget {
  const _CountriesList({required this.confederation});

  final FootballConfederations confederation;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return BlocBuilder<AllCountriesBloc, AllCountriesState>(
      bloc: getIt.get(),
      builder: (context, allCountriesState) {
        final countries = (allCountriesState.countries ?? []).where((c) => c.confederation == confederation).toList();

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: EdgeInsets.only(top: mq.padding.top + 80, left: 20, right: 20, bottom: 250),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return _CountryTile(country: countries[index]);
            },
          ),
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({required this.country});

  final FootballNationalTeamModel country;

  Future<({double progress, int savedCount, int totalCount})> _calculateProgress(List<String> savedCardsIds) async {
    await Future.delayed(Duration.zero); // Даем возможность обновить UI
    final allPlayers = getIt.get<AllFootballPlayersBloc>().state.allPlayers ?? [];
    final countryPlayers = allPlayers.where((player) => player.teamId == country.id).toList();
    final savedCount = countryPlayers.where((player) => savedCardsIds.contains(player.cardId)).length;
    final totalCount = countryPlayers.length;
    final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;
    return (progress: progress, savedCount: savedCount, totalCount: totalCount);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get<SavedCardsBloc>(),
      builder: (context, savedState) {
        final savedPlayerIds = savedState.savedCardsIds ?? [];

        return FutureBuilder<({double progress, int savedCount, int totalCount})>(
          future: _calculateProgress(savedPlayerIds),
          builder: (context, snapshot) {
            final isLoading = snapshot.connectionState == ConnectionState.waiting;
            final progress = isLoading ? 0.0 : snapshot.data?.progress ?? 0.0;
            final savedCount = isLoading ? 0 : snapshot.data?.savedCount ?? 0;
            final totalCount = isLoading ? 0 : snapshot.data?.totalCount ?? 0;

            return GestureDetector(
              onTap: () {
                context.push(RoutePaths.footballPlayersAlbum, extra: country);
              },
              child: SquareProgressIndicator(
                value: progress,
                width: 100,
                height: 100,
                borderRadius: 24,
                startPosition: StartPosition.topCenter,
                strokeCap: StrokeCap.square,
                clockwise: true,
                color: Colors.greenAccent,
                emptyStrokeColor: country.confederation.color,
                strokeWidth: 4,
                emptyStrokeWidth: 4,
                strokeAlign: SquareStrokeAlign.outside,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: country.confederation.color?.darken().withAlpha(200),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          child: Text(emojiFlagByCountryName(country.name) ?? "🏴‍☠️", style: TextStyle(fontSize: 32)),
                        ),
                        Align(
                          child: AutoSizeText(
                            country.name,
                            minFontSize: 12,
                            maxFontSize: 20,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                        Align(
                          child: Text(
                            isLoading ? "" : "$savedCount / $totalCount",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
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
