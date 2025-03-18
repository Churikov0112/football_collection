import 'package:equatable/equatable.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';

class CountryModel extends Equatable {
  final String id;
  final String name;
  final Confederations confederation;

  const CountryModel({
    required this.id,
    required this.name,
    required this.confederation,
  });

  factory CountryModel.fromJson(Map<dynamic, dynamic> json) {
    return CountryModel(
      id: json['id'],
      name: json['name'],
      confederation: confederationFromCountryName(json['name']),
    );
  }

  @override
  List<Object?> get props => [id];
}
