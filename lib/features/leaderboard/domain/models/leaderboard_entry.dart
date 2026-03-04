import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String country;
  final int totalCards;

  const LeaderboardEntry({required this.country, required this.totalCards});

  @override
  List<Object?> get props => [country, totalCards];
}
