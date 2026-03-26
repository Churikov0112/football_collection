part of 'countries_screen.dart';

class FootballCountriesScreenPresenter extends StatefulWidget {
  static FootballCountriesScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballCountriesScreenPresenterState>()!;
  }

  final Widget child;

  const FootballCountriesScreenPresenter({required this.child, super.key});

  @override
  State<FootballCountriesScreenPresenter> createState() => FootballCountriesScreenPresenterState();
}

class FootballCountriesScreenPresenterState extends State<FootballCountriesScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
