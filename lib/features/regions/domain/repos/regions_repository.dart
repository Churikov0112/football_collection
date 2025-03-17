import 'package:football_collection/features/regions/domain/models/region.dart';
import 'package:injectable/injectable.dart';

@singleton
class RegionsRepository {
  Future<List<RegionModel>> regionsGet() async {
    return [
      RegionModel(
        name: "Африка",
        code: "AF",
      ),
      RegionModel(
        name: "Азия",
        code: "AS",
      ),
      RegionModel(
        name: "Европа",
        code: "EU",
      ),
      RegionModel(
        name: "Северная Америка",
        code: "NA",
      ),
      RegionModel(
        name: "Южная Америка",
        code: "SA",
      ),
      RegionModel(
        name: "Австралия и Океания",
        code: "OC",
      ),
    ];
  }
}
