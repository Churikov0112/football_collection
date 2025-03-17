part of 'country_players_bloc.dart';

sealed class CountryPlayersEvent {}

final class CountryPlayersEventGet extends CountryPlayersEvent {
  final String countryCode;

  CountryPlayersEventGet({
    required this.countryCode,
  });
}
