import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final String id;
  final String countryId;
  final String name;
  final String position;

  const PlayerModel({
    required this.id,
    required this.countryId,
    required this.name,
    required this.position,
  });

  factory PlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      countryId: json['team_id'],
      name: json['name'],
      position: json['position'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'countryId': countryId,
      'name': name,
      'position': position,
    };
  }

  @override
  List<Object?> get props => [id];
}
