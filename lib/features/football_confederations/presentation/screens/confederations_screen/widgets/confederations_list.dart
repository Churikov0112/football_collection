part of '../football_confederations_screen.dart';

class _RegionsList extends StatelessWidget {
  const _RegionsList();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final repository = getIt.get<CommonFootballRepository>();

    return FutureBuilder<List<FootballConfederations>>(
      future: repository.footballConfederationsGet(),
      builder: (context, regionsState) {
        final confederations = regionsState.data ?? [];

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
            itemCount: confederations.length,
            itemBuilder: (context, index) {
              return _RegionTile(confederation: confederations[index]);
            },
          ),
        );
      },
    );
  }
}

class _RegionTile extends StatelessWidget {
  const _RegionTile({required this.confederation});

  final FootballConfederations confederation;

  @override
  Widget build(BuildContext context) {
    final repo = getIt.get<CommonFootballRepository>();
    return FutureBuilder<List<FootballNationalTeamModel>>(
      future: repo.teamsGet(confederation: confederation),
      builder: (context, allTeamsState) => FutureBuilder<List<CardModel>>(
        future: repo.getCards(cardTypes: CardType.values.toSet()),
        builder: (context, allCardsState) => BlocBuilder<SavedCardsBloc, SavedCardsState>(
          bloc: getIt.get<SavedCardsBloc>(),
          builder: (context, savedState) {
            final savedCardIds = savedState.savedCardsIds ?? const <String>[];
            final savedCardIdsSet = savedCardIds.toSet();
            final allCards = allCardsState.data ?? const <CardModel>[];
            final confederationCountries = allTeamsState.data ?? const <FootballNationalTeamModel>[];
            final confederationCountryIds = confederationCountries.map((country) => country.id).toSet();

            var savedCount = 0;
            var totalCount = 0;
            for (final card in allCards) {
              final teamId = card.teamId;
              if (teamId == null || !confederationCountryIds.contains(teamId)) continue;
              totalCount += 1;
              if (savedCardIdsSet.contains(card.cardId)) savedCount += 1;
            }

            final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;

            return GestureDetector(
              onTap: () {
                context.push(RoutePaths.footballCountries, extra: confederation);
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
                              style: const TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                        Align(
                          child: Text(
                            totalCount == 0 ? "" : "$savedCount / $totalCount",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
