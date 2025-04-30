part of '../onboarding_screen.dart';

class _OnboardingPage5 extends StatelessWidget {
  const _OnboardingPage5();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = OnboardingScreenPresenter.of(context);

    return BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
      builder: (context, randomFootballPlayersState) {
        final players = randomFootballPlayersState.players ?? [];
        if (players.isEmpty) return Center(child: CircularProgressIndicator());

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: mq.padding.top),
              const Spacer(),
              Translator(
                termin: AppGlossary.onboardingShareCardsWithFriendsOrSell,
                builder: (value) => Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Translator(
                termin: AppGlossary.onboardingShareCardsWithFriendsOrSellDescription,
                builder: (value) => Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const Spacer(),
              StreamBuilder<int>(
                stream: presenter.playersDuplicatesStream,
                builder: (context, playersDuplicatesSnapshot) {
                  return FootballPlayerCard(
                    player: players[0],
                    count: playersDuplicatesSnapshot.data ?? 1,
                    enableFlip: true,
                    onSell: () {
                      presenter.playersDuplicatesSubject.add(1);
                    },
                    onShare: () {
                      presenter.playersDuplicatesSubject.add(1);
                    },
                    onSellAll: () {
                      presenter.playersDuplicatesSubject.add(1);
                    },
                  );
                },
              ),
              const Spacer(),
              SizedBox(
                width: mq.size.width,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
                  ),
                  onPressed: presenter.endOnboarding,
                  child: Translator(
                    termin: AppGlossary.onboardingStartCollectioning,
                    builder: (value) => Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
