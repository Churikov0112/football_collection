part of 'selected_country_bloc.dart';

sealed class SelectedCountryState {
  CountryModel? get country {
    return switch (this) {
      SelectedCountryStateSelected() => (this as SelectedCountryStateSelected)._country,
      _ => null,
    };
  }
}

final class SelectedCountryStateInitial extends SelectedCountryState {
  SelectedCountryStateInitial();
}

final class SelectedCountryStateSelected extends SelectedCountryState {
  final CountryModel _country;
  SelectedCountryStateSelected(this._country);
}
