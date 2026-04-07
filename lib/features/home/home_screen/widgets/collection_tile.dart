part of '../home_screen.dart';

class _CollectionTile extends StatelessWidget {
  const _CollectionTile({required this.allCards, required this.showOriginal});

  final List<CardModel> allCards;
  final bool showOriginal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<SavedCardsBloc, SavedCardsState>(
      bloc: getIt.get<SavedCardsBloc>(),
      builder: (context, savedState) {
        final savedPlayerIds = savedState.savedCardsIds ?? const <String>[];
        final savedPlayerIdsSet = savedPlayerIds.toSet();
        final totalCount = allCards.length;
        final savedCount = allCards.where((player) => savedPlayerIdsSet.contains(player.cardId)).length;
        final progress = totalCount == 0 ? 0.0 : savedCount / totalCount;

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
                              fontSize: 32,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      Align(
                        child: Text(
                          totalCount == 0 ? "" : "$savedCount / $totalCount",
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
  }
}
