part of 'countries_screen.dart';

class CountriesScreenPresenter extends StatefulWidget {
  static CountriesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<CountriesScreenPresenterState>()!;
  }

  final Widget child;
  final Confederations confederation;

  const CountriesScreenPresenter({
    required this.confederation,
    required this.child,
    super.key,
  });

  @override
  State<CountriesScreenPresenter> createState() => CountriesScreenPresenterState();
}

class CountriesScreenPresenterState extends State<CountriesScreenPresenter> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getIt.get<CountriesBloc>().add(CountriesEventGet(confederation: widget.confederation));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
