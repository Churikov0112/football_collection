part of '../draft_screen.dart';

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final presenter = DraftScreenPresenter.of(context);
    final mq = MediaQuery.of(context);

    return StreamBuilder(
      stream: presenter.draftPage$,
      builder: (context, draftPageSnapshot) {
        final page = draftPageSnapshot.data;

        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.black54,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: mq.padding.top + 16,
              right: 16,
              left: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (page == 1) {
                            final confirmExit = await showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Exit Draft? You will lose your draft progress and 🏆.",
                                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),

                                        // const Text(
                                        //   "The Data Packs listed are created and distributed by our dedicated fan community, not affiliated with or endorsed by Monkey I-Brow Studios. Its content can modify logos and names of competitions, clubs, players, trophies, adboards and stadiums. Monkey I-Brow Studios does not claim ownership, review, or control over the content of these packs and expressly disclaim any responsibility or liability for any potential copyright or trademark infringement contained within these packs.",
                                        // ),
                                        // const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                context.pop(false);
                                              },
                                              child: Text(
                                                AppGlossary.cancel.translate(),
                                                style: const TextStyle(color: Colors.white54),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            OutlinedButton(
                                              onPressed: () {
                                                context.pop(true);
                                              },
                                              child: Text(
                                                AppGlossary.exitDraft.translate(),
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            if (confirmExit == true) {
                              context.pop();
                            }
                          } else {
                            presenter.previousPage();
                          }
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Translator(
                        termin: AppGlossary.draft,
                        builder: (value) => Text(
                          value, // $page/3",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (page != null) _PageIndicator(current: page, total: 3),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      StreamBuilder<List<(FootballPlayerPositionOnField, FootballPlayerGameModel?)>>(
                        stream: presenter.startingSquad$,
                        builder: (context, startingSquadSnapshot) {
                          if (startingSquadSnapshot.data?.where((tuple) => tuple.$2 != null).length == 11) {
                            return const _NextButton();
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      spacing: 8,
      children: [
        for (var i = 0; i < total; i++)
          DecoratedBox(
            decoration: BoxDecoration(
              color: i + 1 == current ? theme.colorScheme.primary : theme.colorScheme.primary.withAlpha(75),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: const SizedBox(height: 8, width: 16),
          ),
      ],
    );

    // return SizedBox(
    //   height: 48,
    //   child: ListView.separated(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.horizontal,
    //     physics: const NeverScrollableScrollPhysics(),
    //     separatorBuilder: (context, index) {
    //       return const SizedBox(width: 16);
    //     },
    //     itemCount: total,
    //     itemBuilder: (context, index) {
    //       return CircleAvatar(
    //         backgroundColor: index + 1 == current
    //             ? theme.colorScheme.primary
    //             : theme.colorScheme.primary.withAlpha(100),
    //         child: Text(
    //           (index + 1).toString(),
    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: Colors.white,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
