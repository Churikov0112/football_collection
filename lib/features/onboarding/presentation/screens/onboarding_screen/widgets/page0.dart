part of '../onboarding_screen.dart';

class _OnboardingPage0 extends StatelessWidget {
  const _OnboardingPage0();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final presenter = OnboardingScreenPresenter.of(context);

    return GridView.builder(
      physics: ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1 / 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      padding: EdgeInsets.only(top: mq.padding.top + 20, left: 20, right: 20, bottom: mq.padding.bottom + 20),
      itemCount: Languages.values.length,
      itemBuilder: (context, index) {
        final language = Languages.values[index];
        return GestureDetector(
          onTap: () {
            getIt.get<LanguageBloc>().add(LanguageBlocEventSet(language: language));
            presenter.onboardingController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            );
          },
          child: LanguageTile(
            language: language,
          ),
        );
      },
    );
  }
}
