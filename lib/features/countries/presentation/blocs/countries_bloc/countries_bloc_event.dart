part of 'countries_bloc.dart';

sealed class CountriesEvent {}

final class CountriesEventGet extends CountriesEvent {
  CountriesEventGet({
    required this.regionCode,
  });

  final String regionCode;
}
