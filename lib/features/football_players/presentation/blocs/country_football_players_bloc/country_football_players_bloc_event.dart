part of 'country_football_players_bloc.dart';

sealed class CountryFootballPlayersEvent {}

final class CountryFootballPlayersEventGet extends CountryFootballPlayersEvent {
  final String countryId;

  CountryFootballPlayersEventGet({
    required this.countryId,
  });
}
