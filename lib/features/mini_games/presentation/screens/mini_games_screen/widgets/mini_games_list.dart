part of '../mini_games_screen.dart';

class _MiniGamesList extends StatelessWidget {
  const _MiniGamesList();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Expanded(
      child: GridView(
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: EdgeInsets.only(top: mq.padding.top + 80, left: 20, right: 20, bottom: 200),
        children: [
          _MiniGameTile(
            title: AppGlossary.draft,
            color: Colors.pinkAccent,
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(name: "mini_game_opened", parameters: {"mini_game": "draft"});
              } catch (e) {
                LogService.error(e.toString(), e);
              }

              final savedCardsIds = getIt.get<SavedCardsBloc>().state.savedCardsIds ?? [];
              if (savedCardsIds.length < 100) {
                ToastService.showErrorToast(title: AppGlossary.draftLimitation.translate());
                return;
              }

              BottomSheetController.showBottomSheet(context, (context) => const DraftDescriptionScreen());
            },
          ),
          _MiniGameTile(
            title: AppGlossary.guessTransferValue,
            color: Colors.blue,
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "guess_transfer_value"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessTransferValue);
            },
          ),
          _MiniGameTile(
            title: AppGlossary.whoCostsMore,
            color: Colors.purple,
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "who_is_more_expensive"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessWhoIsMoreExpensive);
            },
          ),
          _MiniGameTile(
            title: AppGlossary.guessPlayerTeam,
            color: Colors.red,
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "guess_national_team"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessNationalTeam);
            },
          ),
          _MiniGameTile(
            title: AppGlossary.guessPlayer,
            color: Colors.teal,
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "guess_player"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessPlayer);
            },
          ),

          _MiniGameTile(
            title: AppGlossary.marketValueUpOrDown,
            color: Colors.blueAccent.darken(0.3),
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "market_value_up_or_down"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameMarketValueUpOrDown);
            },
          ),

          _MiniGameTile(
            title: AppGlossary.guessPlayerSponsor,
            color: const Color.fromARGB(255, 255, 68, 211),
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "guess_player_sponsor"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessPlayerSponsor);
            },
          ),
          _MiniGameTile(
            title: AppGlossary.guessSecondCitizenship,
            color: const Color.fromARGB(255, 112, 0, 0),
            onTap: () {
              try {
                FirebaseAnalytics.instance.logEvent(
                  name: "mini_game_opened",
                  parameters: {"mini_game": "guess_second_citizenship"},
                );
              } catch (e) {
                LogService.error(e.toString(), e);
              }
              context.push(RoutePaths.footballMiniGameGuessSecondCitizenship);
            },
          ),
          // _MiniGameTile(
          //   color: Colors.orange,
          //   title: "Guess national team",
          //   onTap: () {},
          // ),
          // _MiniGameTile(
          //   color: Colors.pink,
          //   title: "Guess player by properties",
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}

class _MiniGameTile extends StatelessWidget {
  const _MiniGameTile({required this.title, required this.color, required this.onTap});

  final AppGlossary title;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color.withAlpha(180),
          border: Border.all(color: color, width: 4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Translator(
                termin: title,
                builder: (value) => Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
