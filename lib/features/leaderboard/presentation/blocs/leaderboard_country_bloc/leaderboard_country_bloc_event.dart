part of 'leaderboard_country_bloc.dart';

sealed class LeaderboardCountryEvent {}

final class LeaderboardCountryEventSelect extends LeaderboardCountryEvent {
  final String countryName;

  LeaderboardCountryEventSelect({required this.countryName});
}
