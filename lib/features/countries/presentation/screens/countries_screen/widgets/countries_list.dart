part of '../countries_screen.dart';

class _CountriesList extends StatelessWidget {
  const _CountriesList({required this.confederation});

  final FootballConfederations confederation;

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<CommonFootballRepository>();
    final mq = MediaQuery.of(context);

    return FutureBuilder(
      future: repo.teamsGet(),
      builder: (context, allCountriesState) {
        final countries = (allCountriesState.data ?? []).where((c) => c.confederation == confederation).toList();
        countries.sort((a, b) => a.name.compareTo(b.name));

        return Expanded(
          child: GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: EdgeInsets.only(top: mq.padding.top + 85, left: 16, right: 16, bottom: mq.padding.bottom + 100),

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
    final repo = getIt.get<CommonFootballRepository>();

    return FutureBuilder(
      future: repo.getCards(cardTypes: CardType.values.toSet()),
      builder: (context, allCardsSnapshot) {
        return BlocBuilder<SavedCardsBloc, SavedCardsState>(
          bloc: getIt.get<SavedCardsBloc>(),
          builder: (context, savedState) {
            final savedCardIds = savedState.savedCardsIds ?? const <String>[];
            final savedCardIdsSet = savedCardIds.toSet();
            final allCards = allCardsSnapshot.data ?? const <CardModel>[];

            var savedCount = 0;
            var totalCount = 0;
            for (final card in allCards) {
              if (card.teamId != country.id) continue;
              totalCount += 1;
              if (savedCardIdsSet.contains(card.cardId)) savedCount += 1;
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
      },
    );
  }
}
