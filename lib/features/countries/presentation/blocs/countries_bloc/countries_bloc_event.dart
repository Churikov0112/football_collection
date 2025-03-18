part of 'countries_bloc.dart';

sealed class CountriesEvent {}

final class CountriesEventGet extends CountriesEvent {
  CountriesEventGet({
    required this.confederation,
  });

  final Confederations confederation;
}
