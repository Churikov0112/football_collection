part of 'countries_screen.dart';

class CountriesScreenPresenter extends StatefulWidget {
  static CountriesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<CountriesScreenPresenterState>()!;
  }

  final Widget child;
  final RegionModel region;

  const CountriesScreenPresenter({
    required this.region,
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
      getIt.get<CountriesBloc>().add(CountriesEventGet(regionCode: widget.region.code));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
