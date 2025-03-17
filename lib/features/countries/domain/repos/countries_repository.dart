import 'package:football_collection/features/countries/domain/models/country.dart';
import 'package:injectable/injectable.dart';

@singleton
class CountriesRepository {
  Future<List<CountryModel>> countriesGet(String regionCode) async {
    if (regionCode != "EU") return [];

    return [
      CountryModel(
        name: "Англия",
        code: "EN",
        regionCode: regionCode,
      ),
      CountryModel(
        name: "Испания",
        code: "ES",
        regionCode: regionCode,
      ),
      CountryModel(
        name: "Италия",
        code: "IT",
        regionCode: regionCode,
      ),
      CountryModel(
        name: "Германия",
        code: "DE",
        regionCode: regionCode,
      ),
      CountryModel(
        name: "Франция",
        code: "FR",
        regionCode: regionCode,
      ),
    ];
  }
}
