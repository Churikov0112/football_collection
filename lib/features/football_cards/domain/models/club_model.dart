import 'package:equatable/equatable.dart';

class FootballClubModel extends Equatable {
  final String id;
  final String name;
  final DateTime? foundedOn;
  final List<dynamic>? colors;
  final String? stadiumName;
  final int? stadiumSeats;
  final int? currentMarketValue;
  final FootballLeagueModel? league;

  const FootballClubModel({
    required this.id,
    required this.name,
    required this.foundedOn,
    required this.colors,
    required this.stadiumName,
    required this.stadiumSeats,
    required this.currentMarketValue,
    required this.league,
  });

  factory FootballClubModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballClubModel(
      id: json['id'],
      name: json['name'],
      foundedOn: json['foundedOn'] != null ? DateTime.tryParse(json['foundedOn']) : null,
      colors: json['colors'],
      stadiumName: json['stadiumName'],
      stadiumSeats: json['stadiumSeats'],
      currentMarketValue: json['currentMarketValue'],
      league: json['league']['id'] != null ? FootballLeagueModel.fromJson(json['league']) : null,
    );
  }

  @override
  List<Object?> get props => [id];
}

class FootballLeagueModel extends Equatable {
  final String id;
  final String name;
  final String? countryId;
  final String? countryName;
  final String? tier;

  const FootballLeagueModel({
    required this.id,
    required this.name,
    required this.countryId,
    required this.countryName,
    required this.tier,
  });

  factory FootballLeagueModel.fromJson(Map<dynamic, dynamic> json) {
    return FootballLeagueModel(
      id: json['id'],
      name: json['name'],
      countryId: json['countryId'],
      countryName: json['countryName'],
      tier: json['tier'],
    );
  }

  @override
  List<Object?> get props => [id];
}
