part of 'leaderboard_country_bloc.dart';

sealed class LeaderboardCountryState {
  String? get countryName {
    return switch (this) {
      LeaderboardCountryStateSelected() => (this as LeaderboardCountryStateSelected)._countryName,
      _ => null,
    };
  }
}

final class LeaderboardCountryStateInitial extends LeaderboardCountryState {
  LeaderboardCountryStateInitial();
}

final class LeaderboardCountryStateSelected extends LeaderboardCountryState {
  final String _countryName;

  LeaderboardCountryStateSelected(this._countryName);
}
