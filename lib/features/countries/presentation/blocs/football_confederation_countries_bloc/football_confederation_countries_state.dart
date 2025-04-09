part of 'football_confederation_countries_bloc.dart';

sealed class FootballConfederationCountriesState {
  List<CountryModel>? get countries {
    return switch (this) {
      FootballConfederationCountriesStateLoadSucceeded() =>
        (this as FootballConfederationCountriesStateLoadSucceeded)._countries,
      _ => null,
    };
  }
}

final class FootballConfederationCountriesStateInitial extends FootballConfederationCountriesState {
  FootballConfederationCountriesStateInitial();
}

final class FootballConfederationCountriesStatePending extends FootballConfederationCountriesState {
  FootballConfederationCountriesStatePending();
}

final class FootballConfederationCountriesStateLoadSucceeded extends FootballConfederationCountriesState {
  final List<CountryModel> _countries;
  FootballConfederationCountriesStateLoadSucceeded(this._countries);
}

final class FootballConfederationCountriesStateFailed extends FootballConfederationCountriesState {
  final String reason;
  FootballConfederationCountriesStateFailed(this.reason);
}
