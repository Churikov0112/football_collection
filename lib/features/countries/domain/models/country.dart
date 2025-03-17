import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final String name;
  final String code;
  final String regionCode;

  const CountryModel({
    required this.name,
    required this.code,
    required this.regionCode,
  });

  factory CountryModel.fromJson(Map<dynamic, dynamic> json) {
    return CountryModel(
      name: json['name'],
      code: json['code'],
      regionCode: json['regionCode'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'regionCode': regionCode,
    };
  }

  @override
  List<Object?> get props => [code];
}
