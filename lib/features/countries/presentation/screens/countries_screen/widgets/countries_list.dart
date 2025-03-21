part of '../countries_screen.dart';

class _CountriesList extends StatelessWidget {
  const _CountriesList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesBloc, CountriesState>(
      bloc: getIt.get(),
      builder: (context, countriesState) {
        final countries = countriesState.countries ?? [];

        return Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 120),
            itemCount: countries.length,
            itemBuilder: (context, index) {
              return _CountryTile(
                country: countries[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
  });

  final CountryModel country;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RoutePaths.album, extra: country);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: country.confederation.color?.darken(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              country.emojiFlag ?? "🏴‍☠️",
              style: TextStyle(fontSize: 32),
            ),
            Text(
              country.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),

            // Text(country.confederation.name),
          ],
        ),
      ),
    );
  }
}
