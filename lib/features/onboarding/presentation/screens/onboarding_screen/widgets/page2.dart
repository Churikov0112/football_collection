part of '../onboarding_screen.dart';

class _OnboardingPage2 extends StatelessWidget {
  const _OnboardingPage2();

  @override
  Widget build(BuildContext context) {
    final presenter = OnboardingScreenPresenter.of(context);

    return BlocBuilder<RandomFootballPlayersBloc, RandomFootballPlayersState>(
      builder: (context, randomFootballPlayersState) {
        final players = randomFootballPlayersState.players ?? [];
        if (players.isEmpty) return Center(child: CircularProgressIndicator());

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Translator(
                termin: AppGlossary.onboardingOpenPacks,
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
                termin: AppGlossary.onboardingTapOnPackToOpenIt,
                builder: (value) => Text(
                  value, // 'Tap on the pack to open it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  presenter.onboardingController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Image.asset(
                  "assets/raster/packs/pack-topplayers.png",
                  height: packHeight,
                  width: packWidth,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
