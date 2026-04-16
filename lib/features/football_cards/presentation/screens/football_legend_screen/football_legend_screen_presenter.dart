part of 'football_legend_screen.dart';

class FootballLegendScreenPresenter extends StatefulWidget {
  static FootballLegendScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<FootballLegendScreenPresenterState>()!;
  }

  final Widget child;

  const FootballLegendScreenPresenter({required this.child, super.key});

  @override
  State<FootballLegendScreenPresenter> createState() => FootballLegendScreenPresenterState();
}

class FootballLegendScreenPresenterState extends State<FootballLegendScreenPresenter> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
