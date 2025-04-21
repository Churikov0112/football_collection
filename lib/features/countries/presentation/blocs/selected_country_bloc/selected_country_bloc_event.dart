part of 'selected_country_bloc.dart';

sealed class SelectedCountryEvent {}

final class SelectedCountryEventSelect extends SelectedCountryEvent {
  final CountryModel country;

  SelectedCountryEventSelect({
    required this.country,
  });
}

final class SelectedCountryEventReset extends SelectedCountryEvent {
  SelectedCountryEventReset();
}
