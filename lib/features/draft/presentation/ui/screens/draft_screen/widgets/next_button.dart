part of '../draft_screen.dart';

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);
    final theme = Theme.of(context);

    return StreamBuilder(
      stream: presenter.startingSquad$,
      builder: (context, startingSquadSnapshot) {
        final startingSquad = startingSquadSnapshot.data ?? [];
        final isStartingSquadFull = startingSquad.map((e) => e.$2).toList().length == 11;

        return StreamBuilder(
          stream: presenter.draftPage$,
          builder: (context, draftPageSnapshot) {
            final page = draftPageSnapshot.data;

            return StreamBuilder(
              stream: presenter.captainId$,
              builder: (context, captainIdSnapshot) {
                final hasCaptain = captainIdSnapshot.data != null;

                if ((page == 1 && !isStartingSquadFull) || (page == 2 && !hasCaptain)) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: presenter.nextPage,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Translator(
                            termin: AppGlossary.next,
                            builder: (value) => Text(
                              value,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black,
                              ),
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
