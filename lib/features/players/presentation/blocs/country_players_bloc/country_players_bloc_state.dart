part of 'country_players_bloc.dart';

sealed class CountryPlayersState {
  List<PlayerModel>? get players {
    return switch (this) {
      CountryPlayersStateLoadSucceeded() => (this as CountryPlayersStateLoadSucceeded)._players,
      _ => null,
    };
  }

  CountryModel? get country {
    return switch (this) {
      CountryPlayersStateLoadSucceeded() => (this as CountryPlayersStateLoadSucceeded)._country,
      _ => null,
    };
  }
}

final class CountryPlayersStateInitial extends CountryPlayersState {
  CountryPlayersStateInitial();
}

final class CountryPlayersStatePending extends CountryPlayersState {
  CountryPlayersStatePending();
}

final class CountryPlayersStateLoadSucceeded extends CountryPlayersState {
  final List<PlayerModel> _players;
  final CountryModel _country;

  CountryPlayersStateLoadSucceeded(
    this._players,
    this._country,
  );
}

final class CountryPlayersStateFailed extends CountryPlayersState {
  final String reason;
  CountryPlayersStateFailed(this.reason);
}
