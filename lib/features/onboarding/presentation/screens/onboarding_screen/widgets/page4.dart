part of '../onboarding_screen.dart';

class _OnboardingPage4 extends StatelessWidget {
  const _OnboardingPage4();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = OnboardingScreenPresenter.of(context);

    return BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
      builder: (context, randomFootballPlayersState) {
        final players = randomFootballPlayersState.players ?? [];
        if (players.isEmpty) return Center(child: CircularProgressIndicator());

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: mq.padding.top + 20),
                  Translator(
                    termin: AppGlossary.onboardingCardsAreSaved,
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
                    termin: AppGlossary.onboardingTapOnCardToSeeInfo,
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
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      padding: EdgeInsets.only(top: 20, bottom: mq.padding.bottom + 100),
                      itemCount: players.length,
                      itemBuilder: (context, index) {
                        return FootballPlayerCard(
                          player: players[index],
                          count: 1,
                          enableFlip: true,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: mq.padding.bottom + 16,
              left: 16,
              right: 16,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.deepOrange),
                ),
                onPressed: () {
                  presenter.onboardingController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
                child: Translator(
                  termin: AppGlossary.next,
                  builder: (value) => Text(
                    value,
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
