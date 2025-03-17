import 'package:equatable/equatable.dart';

class RegionModel extends Equatable {
  final String name;
  final String code;

  const RegionModel({
    required this.name,
    required this.code,
  });

  factory RegionModel.fromJson(Map<dynamic, dynamic> json) {
    return RegionModel(
      name: json['name'],
      code: json['code'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [code];
}
