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
