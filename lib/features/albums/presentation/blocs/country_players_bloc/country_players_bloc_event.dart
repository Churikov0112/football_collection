part of 'country_players_bloc.dart';

sealed class CountryPlayersEvent {}

final class CountryPlayersEventGet extends CountryPlayersEvent {
  final String countryId;

  CountryPlayersEventGet({
    required this.countryId,
  });
}
