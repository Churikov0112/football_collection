part of '../draft_screen.dart';

class _SquadRating extends StatelessWidget {
  const _SquadRating();

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);

    return StreamBuilder(
      stream: presenter.connectionsChemistry$,
      builder: (context, connectionsChemistrySnapshot) {
        final List<(PositionConnectionRule, double)> connectionsChemistry = connectionsChemistrySnapshot.data ?? [];

        return StreamBuilder(
          stream: presenter.startingSquad$,
          builder: (context, startingSquadSnapshot) {
            final ratings =
                startingSquadSnapshot.data?.map((e) => e.$2?.card.sfData.ratings?.overall ?? 0).toList() ?? [];
            int overall = 0;
            for (var i = 0; i < ratings.length; i++) {
              overall += ratings[i];
            }

            double chemistry = 0;
            for (var i = 0; i < connectionsChemistry.length; i++) {
              chemistry += connectionsChemistry[i].$2;
            }

            if (connectionsChemistry.isNotEmpty) {
              chemistry = chemistry / connectionsChemistry.length;
            }

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Row(
                      children: [
                        Translator(
                          termin: AppGlossary.rating,
                          builder: (value) => Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        RatingTag(
                          value: overall,
                          color: ratingColor(overall ~/ 11),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Row(
                      children: [
                        Translator(
                          termin: AppGlossary.chemistry,
                          builder: (value) => Text(
                            value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            color: ratingColor((chemistry * 100).round())?.darken(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            child: Center(
                              child: Text(
                                "${(chemistry * 100).toStringAsFixed(0)}%",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
