part of '../onboarding_screen.dart';

class _OnboardingPage1 extends StatelessWidget {
  const _OnboardingPage1();

  @override
  Widget build(BuildContext context) {
    final presenter = OnboardingScreenPresenter.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Translator(
            termin: AppGlossary.onboardingWelcome,
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
            termin: AppGlossary.onboardingWhoWeAre,
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
          Translator(
            termin: AppGlossary.onboardingPressPacksButton,
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
          OpenPacksScreenButton(
            onPressed: () {
              presenter.onboardingController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
              );
            },
          ),
        ],
      ),
    );
  }
}
