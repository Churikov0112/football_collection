// coach_card.dart
import 'package:football_collection/features/abstract/domain/models/card.dart';

class FootballCoachCardModel extends CardModel {
  final String coachId;

  @override
  final String name;

  @override
  final String? teamId;

  final String? teamName;
  final dynamic citizenship;

  const FootballCoachCardModel({
    required super.cardId,
    required super.imageAssetPath,
    super.cardType = CardType.coach,
    required this.coachId,
    required this.name,
    required this.teamId,
    required this.teamName,
    required this.citizenship,
  });

  factory FootballCoachCardModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballCoachCardModel(
      coachId: json['id'],
      cardId: "football_coach-${json['id']}",
      imageAssetPath: "assets/raster/coach_faces/${json['id']}.jpg",
      name: json['name'],
      teamId: json['current_club']?['id'],
      teamName: json['current_club']?['name'],
      citizenship: json['citizenship'],
    );
  }

  @override
  List<Object?> get props => [cardId, coachId];
}
