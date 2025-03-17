part of 'regions_screen.dart';

class RegionsScreenPresenter extends StatefulWidget {
  static RegionsScreenPresenterState of(BuildContext context) {
    return context.findAncestorStateOfType<RegionsScreenPresenterState>()!;
  }

  final Widget child;

  const RegionsScreenPresenter({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  State<RegionsScreenPresenter> createState() => RegionsScreenPresenterState();
}

class RegionsScreenPresenterState extends State<RegionsScreenPresenter> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getIt.get<RegionsBloc>().add(RegionsEventGet());
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
