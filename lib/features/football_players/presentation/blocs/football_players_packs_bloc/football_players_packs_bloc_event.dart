part of 'football_players_packs_bloc.dart';

sealed class FootballPlayersPacksEvent {}

final class FootballPlayersPacksEventGet extends FootballPlayersPacksEvent {
  final CountryModel? country;
  final FootballConfederations? confederation;

  FootballPlayersPacksEventGet({
    this.country,
    this.confederation,
  });
}
