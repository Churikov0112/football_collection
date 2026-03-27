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
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: EdgeInsets.only(top: mq.padding.top + 85, left: 20, right: 20, bottom: mq.padding.bottom + 100),

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get<SavedCardsBloc>(),
      builder: (context, savedState) {
        final savedPlayerIds = savedState.savedCardsIds ?? const <String>[];
        final savedPlayerIdsSet = savedPlayerIds.toSet();
        final allPlayers = getIt.get<AllFootballPlayersBloc>().state.allPlayers ?? const <FootballPlayerCardModel>[];

        var savedCount = 0;
        var totalCount = 0;
        for (final player in allPlayers) {
          if (player.teamId != country.id) continue;
          totalCount += 1;
          if (savedPlayerIdsSet.contains(player.cardId)) savedCount += 1;
        }

        final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;

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
                    Align(child: Text(emojiFlagByCountryName(country.name) ?? "🏴‍☠️", style: TextStyle(fontSize: 32))),
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
                        "$savedCount / $totalCount",
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
  }
}
