// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/abstract/presentation/blocs/first_launch_bloc/first_launch_bloc.dart'
    as _i717;
import '../features/abstract/presentation/blocs/saved_cards_bloc/saved_cards_bloc.dart'
    as _i367;
import '../features/abstract/presentation/blocs/settings_bloc/settings_bloc.dart'
    as _i809;
import '../features/countries/domain/repos/countries_repository.dart' as _i71;
import '../features/countries/presentation/blocs/football_confederation_countries_bloc/football_confederation_countries_bloc.dart'
    as _i91;
import '../features/football_confederations/domain/repos/football_confederations_repository.dart'
    as _i47;
import '../features/football_confederations/presentation/blocs/football_confederations_bloc/football_confederations_bloc.dart'
    as _i878;
import '../features/football_players/data/football_players_repository.dart'
    as _i1036;
import '../features/football_players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart'
    as _i245;
import '../features/football_players/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart'
    as _i873;
import '../features/football_players/presentation/blocs/country_football_players_bloc/country_football_players_bloc.dart'
    as _i110;
import '../features/football_players/presentation/blocs/football_players_packs_bloc/football_players_packs_bloc.dart'
    as _i785;
import '../features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart'
    as _i550;
import '../services/localization/language_bloc/language_bloc.dart' as _i381;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i367.SavedCardsBloc>(() => _i367.SavedCardsBloc());
  gh.singleton<_i717.FirstLaunchBloc>(() => _i717.FirstLaunchBloc());
  gh.singleton<_i1036.FootballPlayersRepository>(
      () => _i1036.FootballPlayersRepository());
  gh.singleton<_i550.BalanceBloc>(() => _i550.BalanceBloc());
  gh.singleton<_i47.FootballConfederationsRepository>(
      () => _i47.FootballConfederationsRepository());
  gh.singleton<_i71.CountriesRepository>(() => _i71.CountriesRepository());
  gh.singleton<_i381.LanguageBloc>(() => _i381.LanguageBloc());
  gh.singleton<_i809.SettingsBloc>(() => _i809.SettingsBloc());
  gh.singleton<_i873.AllFootballPlayersBloc>(() => _i873.AllFootballPlayersBloc(
      repository: gh<_i1036.FootballPlayersRepository>()));
  gh.singleton<_i91.FootballConfederationCountriesBloc>(() =>
      _i91.FootballConfederationCountriesBloc(gh<_i71.CountriesRepository>()));
  gh.singleton<_i878.FootballConfederationsBloc>(() =>
      _i878.FootballConfederationsBloc(
          gh<_i47.FootballConfederationsRepository>()));
  gh.singleton<_i245.AllCountriesBloc>(
      () => _i245.AllCountriesBloc(gh<_i1036.FootballPlayersRepository>()));
  gh.singleton<_i110.CountryFootballPlayersBloc>(() =>
      _i110.CountryFootballPlayersBloc(gh<_i1036.FootballPlayersRepository>()));
  gh.singleton<_i785.FootballPlayersPacksBloc>(() =>
      _i785.FootballPlayersPacksBloc(gh<_i1036.FootballPlayersRepository>()));
  return getIt;
}
