import 'package:equatable/equatable.dart';

class FootballClubModel extends Equatable {
  final String id;
  final String name;
  final Map<String, dynamic>? profile;

  const FootballClubModel({required this.id, required this.name, required this.profile});

  factory FootballClubModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballClubModel(id: json['id'], name: json['name'], profile: json['profile']);
  }

  @override
  List<Object?> get props => [id];
}
