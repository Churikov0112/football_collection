part of '../confederations_screen.dart';

class _RegionsList extends StatelessWidget {
  const _RegionsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfederationsBloc, ConfederationsState>(
      bloc: getIt.get(),
      builder: (context, regionsState) {
        final confederations = regionsState.confederations ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: confederations.length,
            itemBuilder: (context, index) {
              return _RegionTile(
                confederation: confederations[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _RegionTile extends StatelessWidget {
  const _RegionTile({
    required this.confederation,
  });

  final Confederations confederation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RoutePaths.countries, extra: confederation);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(confederation.name),
          ],
        ),
      ),
    );
  }
}
