import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final String id;
  final String countryId;
  final String name;
  final String? position;
  final String? birthDate;
  final String? height;
  final String? foot;
  final String? currentClub;
  final int? currentMarketValue;
  final int? maxMarketValue;
  final String? imageUrl;

  const PlayerModel({
    required this.id,
    required this.countryId,
    required this.name,
    required this.position,
    required this.birthDate,
    required this.height,
    required this.foot,
    required this.currentClub,
    required this.currentMarketValue,
    required this.maxMarketValue,
    required this.imageUrl,
  });

  factory PlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      countryId: json['team_id'],
      name: json['name'],
      position: json['position'],
      birthDate: json['birth_date'],
      height: json['height'],
      foot: json['foot'],
      currentClub: json['current_club'],
      currentMarketValue: json['current_market_value'],
      maxMarketValue: json['max_market_value'],
      imageUrl: json['image_url'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'team_id': countryId,
      'name': name,
      'position': position,
      'birth_date': birthDate,
      'height': height,
      'foot': foot,
      'current_club': currentClub,
      'current_market_value': currentMarketValue,
      'max_market_value': maxMarketValue,
      'image_url': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id];
}
