// import 'package:football_collection/features/abstract/domain/models/card.dart';

// class FootballSquadCardModel extends CardModel {
//   @override
//   final String? teamId;

//   final String? teamName;

//   @override
//   final String name;

//   const FootballSquadCardModel({
//     required super.cardId,
//     required super.imageAssetPath,
//     required this.teamId,
//     required this.teamName,
//     required this.name,
//     super.cardType = CardType.squad,
//   });

//   factory FootballSquadCardModel.fromJson(Map<dynamic, dynamic> json) {
//     return FootballSquadCardModel(
//       cardId: "squad_${json['team_id']}",
//       imageAssetPath: "assets/raster/coaches_faces/${json['id']}.jpg",
//       teamId: json['team_id'],
//       teamName: json['team_name'],
//       name: json['team_name'],
//     );
//   }

//   @override
//   List<Object?> get props => [cardId];
// }
