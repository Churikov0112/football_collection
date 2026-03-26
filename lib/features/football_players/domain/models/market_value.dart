import 'package:equatable/equatable.dart';

class FootballPlayerMarketValueModel extends Equatable {
  final String id;
  final String name;
  final String teamId;
  final String teamName;
  final MarketValueModel? marketValue;

  const FootballPlayerMarketValueModel({
    required this.id,
    required this.teamId,
    required this.teamName,
    required this.name,
    required this.marketValue,
  });

  factory FootballPlayerMarketValueModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballPlayerMarketValueModel(
      id: json['id'],
      teamId: json['team_id'],
      teamName: json['team_name'],
      name: json['name'],
      marketValue: json['market_value'] == null ? null : MarketValueModel.fromJson(json['market_value']),
    );
  }

  @override
  List<Object?> get props => [id];
}

class MarketValueModel {
  final String id;
  final String updatedAt;
  final int? marketValue;
  final List<MarketValueHistoryModel>? marketValueHistory;

  MarketValueModel({
    required this.id,
    required this.updatedAt,
    required this.marketValue,
    required this.marketValueHistory,
  });

  factory MarketValueModel.fromJson(Map<String, dynamic> json) => MarketValueModel(
    updatedAt: json["updatedAt"],
    id: json["id"],
    marketValue: json["marketValue"],
    marketValueHistory: List<MarketValueHistoryModel>.from(
      json["marketValueHistory"].map((x) => MarketValueHistoryModel.fromJson(x)),
    ),
  );
}

class MarketValueHistoryModel {
  final int? age;
  final String? date;
  final String? clubId;
  final String? clubName;
  final int? marketValue;

  MarketValueHistoryModel({
    required this.age,
    required this.date,
    required this.clubId,
    required this.clubName,
    required this.marketValue,
  });

  factory MarketValueHistoryModel.fromJson(Map<String, dynamic> json) => MarketValueHistoryModel(
    age: json["age"],
    date: json["date"],
    clubId: json["clubId"],
    clubName: json["clubName"],
    marketValue: json["marketValue"],
  );
}
