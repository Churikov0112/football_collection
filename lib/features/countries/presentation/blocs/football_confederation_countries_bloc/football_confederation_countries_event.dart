part of 'football_confederation_countries_bloc.dart';

sealed class FootballConfederationCountriesEvent {}

final class FootballConfederationCountriesEventGet extends FootballConfederationCountriesEvent {
  FootballConfederationCountriesEventGet({
    required this.confederation,
  });

  final FootballConfederations confederation;
}
