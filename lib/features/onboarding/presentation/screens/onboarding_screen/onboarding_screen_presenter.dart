part of 'onboarding_screen.dart';

class OnboardingScreenPresenter extends StatefulWidget {
  static OnboardingScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<OnboardingScreenPresenterState>()!;
  }

  final Widget child;

  const OnboardingScreenPresenter({required this.child, super.key});

  @override
  State<OnboardingScreenPresenter> createState() => OnboardingScreenPresenterState();
}

class OnboardingScreenPresenterState extends State<OnboardingScreenPresenter> {
  final PageController onboardingController = PageController();

  final BehaviorSubject<int> playersDuplicatesSubject = BehaviorSubject.seeded(2);
  Stream<int> get playersDuplicatesStream => playersDuplicatesSubject.stream;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<RandomFootballPlayersBloc>().add(
        RandomFootballPlayersEventGet(count: 5, minPrimeTransferValue: 50000000),
      );
    });
  }

  void endOnboarding() {
    getIt.get<FirstLaunchBloc>().add(FirstLaunchEventSet(isFirstLaunch: false));
    context.go(RoutePaths.home);
  }

  @override
  void dispose() {
    playersDuplicatesSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
