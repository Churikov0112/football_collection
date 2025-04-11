part of 'onboarding_screen.dart';

class OnboardingScreenPresenter extends StatefulWidget {
  static OnboardingScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<OnboardingScreenPresenterState>()!;
  }

  final Widget child;

  const OnboardingScreenPresenter({
    required this.child,
    super.key,
  });

  @override
  State<OnboardingScreenPresenter> createState() => OnboardingScreenPresenterState();
}

class OnboardingScreenPresenterState extends State<OnboardingScreenPresenter> {
  final PageController onboardingController = PageController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context
          .read<RandomFootballPlayersBloc>()
          .add(RandomFootballPlayersEventGet(count: 5, minPrimeTransferValue: 50000000));
    });
  }

  void endOnboarding() {
    getIt.get<FirstLaunchBloc>().add(FirstLaunchEventSet(isFirstLaunch: false));
    context.go(RoutePaths.footballConfederations);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
