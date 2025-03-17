
part of 'countries_screen.dart';

class CountriesScreenPresenter extends StatefulWidget {
  static CountriesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<CountriesScreenPresenterState>()!;
  }

  final Widget child;

  const CountriesScreenPresenter({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<CountriesScreenPresenter> createState() => CountriesScreenPresenterState();
}

class CountriesScreenPresenterState extends State<CountriesScreenPresenter> {

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
