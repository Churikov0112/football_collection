part of '../onboarding_screen.dart';

class _OnboardingPage3 extends StatelessWidget {
  const _OnboardingPage3();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
      builder: (context, randomFootballPlayersState) {
        final players = randomFootballPlayersState.players ?? [];
        if (players.isEmpty) return Center(child: CircularProgressIndicator());
        players.removeLast();
        players.insert(0, players.first);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Positioned(
                child: Column(
                  children: [
                    SizedBox(height: mq.padding.top + mq.size.height * 0.1),
                    Translator(
                      termin: AppGlossary.onboardingSwipeCardsToSave,
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
                      termin: AppGlossary.onboardingEverySwipedCardWillBeSavedYouCanSwipeAnyDirection,
                      builder: (value) => Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              _OnboardingCardsSwiper(cards: players),
            ],
          ),
        );
      },
    );
  }
}
