part of '../regions_screen.dart';

class _RegionsList extends StatelessWidget {
  const _RegionsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionsBloc, RegionsState>(
      bloc: getIt.get(),
      builder: (context, regionsState) {
        final regions = regionsState.regions ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: regions.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.red,
              );
            },
          ),
        );
      },
    );
  }
}
