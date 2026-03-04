import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String country;
  final int totalCards;
  final int openingsCount;

  const LeaderboardEntry({
    required this.country,
    required this.totalCards,
    required this.openingsCount,
  });

  @override
  List<Object?> get props => [country, totalCards, openingsCount];
}
