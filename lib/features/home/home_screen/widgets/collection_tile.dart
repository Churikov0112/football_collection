part of '../home_screen.dart';

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({required this.competitions, required this.allPlayers, required this.showOriginal});

  final List<FootballConfederations> competitions;
  final List<FootballPlayerCardModel> allPlayers;
  final bool showOriginal;

  Future<({double progress, int savedCount, int totalCount})> _calculateProgress(List<String> savedCardsIds) async {
    await Future.delayed(Duration.zero); // Даем возможность обновить UI
    final savedCount = allPlayers.where((player) => savedCardsIds.contains(player.cardId)).length;
    final totalCount = allPlayers.length;
    final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;
    return (progress: progress, savedCount: savedCount, totalCount: totalCount);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                context.push(RoutePaths.footballConfederations);
              },
              child: SquareProgressIndicator(
                value: progress,
                width: size.width - 32,
                height: 150,
                borderRadius: 24,
                startPosition: StartPosition.topCenter,
                strokeCap: StrokeCap.square,
                clockwise: true,
                color: Colors.greenAccent,
                emptyStrokeColor: Colors.white54,
                strokeWidth: 4,
                emptyStrokeWidth: 4,
                strokeAlign: SquareStrokeAlign.outside,
                child: FrostedGlassContainer(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  blupColor: Colors.white10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(22))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        spacing: 8,
                        children: [
                          Align(
                            child: Translator(
                              termin: AppGlossary.myCollection,
                              builder: (value) => Text(
                                value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          // Align(
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     spacing: 8,
                          //     children: [
                          //       for (final competition in competitions)
                          //         CompetitionLogoWidget(competitionId: competition.id),
                          //     ],
                          //   ),
                          // ),
                          Align(
                            child: Text(
                              isLoading || totalCount == 0 ? "" : "$savedCount / $totalCount",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic,

                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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
