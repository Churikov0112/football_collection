part of 'all_countries_bloc.dart';

sealed class AllCountriesState {
  List<FootballNationalTeamModel>? get countries {
    return switch (this) {
      AllCountriesStateLoadSucceeded() => (this as AllCountriesStateLoadSucceeded)._countries,
      _ => null,
    };
  }
}

final class AllCountriesStateInitial extends AllCountriesState {
  AllCountriesStateInitial();
}

final class AllCountriesStatePending extends AllCountriesState {
  AllCountriesStatePending();
}

final class AllCountriesStateLoadSucceeded extends AllCountriesState {
  final List<FootballNationalTeamModel> _countries;
  AllCountriesStateLoadSucceeded(this._countries);
}

final class AllCountriesStateFailed extends AllCountriesState {
  final String reason;
  AllCountriesStateFailed(this.reason);
}
