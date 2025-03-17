part of 'countries_bloc.dart';

sealed class CountriesState {
  List<CountryModel>? get countries {
    return switch (this) {
      CountriesStateLoadSucceeded() => (this as CountriesStateLoadSucceeded)._countries,
      _ => null,
    };
  }
}

final class CountriesStateInitial extends CountriesState {
  CountriesStateInitial();
}

final class CountriesStatePending extends CountriesState {
  CountriesStatePending();
}

final class CountriesStateLoadSucceeded extends CountriesState {
  final List<CountryModel> _countries;
  CountriesStateLoadSucceeded(this._countries);
}

final class CountriesStateFailed extends CountriesState {
  final String reason;
  CountriesStateFailed(this.reason);
}
