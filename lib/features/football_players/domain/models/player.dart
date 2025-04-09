import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballPlayerModel extends CardModel {
  final String playerId;
  final String countryId;
  final String name;
  final String? position;
  final String? birthDate;
  final String? height;
  final String? foot;
  final String? currentClub;
  final int? currentMarketValue;
  final int? maxMarketValue;

  const FootballPlayerModel({
    required super.cardId,
    required super.imageUrl,
    required super.imageAssetPath,
    required this.playerId,
    required this.countryId,
    required this.name,
    required this.position,
    required this.birthDate,
    required this.height,
    required this.foot,
    required this.currentClub,
    required this.currentMarketValue,
    required this.maxMarketValue,
  });

  factory FootballPlayerModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballPlayerModel(
      cardId: "football_player-${json['id']}",
      imageAssetPath: "assets/raster/player_faces/${json['id']}.jpg",
      imageUrl: json['image_url'],
      playerId: json['id'],
      countryId: json['team_id'],
      name: json['name'],
      position: json['position'],
      birthDate: json['birth_date'],
      height: json['height'],
      foot: json['foot'],
      currentClub: json['current_club'],
      currentMarketValue: json['current_market_value'],
      maxMarketValue: json['max_market_value'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'cardId': cardId,
      'player_id': playerId,
      'image_asset_path': imageAssetPath,
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
  List<Object?> get props => [cardId, playerId];
}
