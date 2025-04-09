part of 'country_football_players_bloc.dart';

sealed class CountryFootballPlayersState {
  List<FootballPlayerModel>? get players {
    return switch (this) {
      CountryFootballPlayersStateLoadSucceeded() => (this as CountryFootballPlayersStateLoadSucceeded)._players,
      _ => null,
    };
  }

  CountryModel? get country {
    return switch (this) {
      CountryFootballPlayersStateLoadSucceeded() => (this as CountryFootballPlayersStateLoadSucceeded)._country,
      _ => null,
    };
  }
}

final class CountryFootballPlayersStateInitial extends CountryFootballPlayersState {
  CountryFootballPlayersStateInitial();
}

final class CountryFootballPlayersStatePending extends CountryFootballPlayersState {
  CountryFootballPlayersStatePending();
}

final class CountryFootballPlayersStateLoadSucceeded extends CountryFootballPlayersState {
  final List<FootballPlayerModel> _players;
  final CountryModel _country;

  CountryFootballPlayersStateLoadSucceeded(
    this._players,
    this._country,
  );
}

final class CountryFootballPlayersStateFailed extends CountryFootballPlayersState {
  final String reason;
  CountryFootballPlayersStateFailed(this.reason);
}
