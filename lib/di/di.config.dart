// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/confederations/domain/repos/confederations_repository.dart'
    as _i108;
import '../features/confederations/presentation/blocs/confederations_bloc/confederations_bloc.dart'
    as _i515;
import '../features/countries/domain/repos/countries_repository.dart' as _i71;
import '../features/countries/presentation/blocs/countries_bloc/countries_bloc.dart'
    as _i167;
import '../features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart'
    as _i550;
import '../features/players/data/players_repository.dart' as _i414;
import '../features/players/presentation/blocs/all_countries_bloc/all_countries_bloc.dart'
    as _i474;
import '../features/players/presentation/blocs/all_players_bloc/all_players_bloc.dart'
    as _i736;
import '../features/players/presentation/blocs/country_players_bloc/country_players_bloc.dart'
    as _i845;
import '../features/players/presentation/blocs/saved_players_bloc/saved_players_bloc.dart'
    as _i794;
import '../features/players/presentation/blocs/stickerpacks_bloc/stickerpacks_bloc.dart'
    as _i347;
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
  gh.singleton<_i108.ConnfederationsRepository>(
      () => _i108.ConnfederationsRepository());
  gh.singleton<_i414.PlayersRepository>(() => _i414.PlayersRepository());
  gh.singleton<_i794.SavedPlayersBloc>(() => _i794.SavedPlayersBloc());
  gh.singleton<_i550.BalanceBloc>(() => _i550.BalanceBloc());
  gh.singleton<_i71.CountriesRepository>(() => _i71.CountriesRepository());
  gh.singleton<_i381.LanguageBloc>(() => _i381.LanguageBloc());
  gh.singleton<_i167.CountriesBloc>(
      () => _i167.CountriesBloc(gh<_i71.CountriesRepository>()));
  gh.singleton<_i736.AllPlayersBloc>(
      () => _i736.AllPlayersBloc(repository: gh<_i414.PlayersRepository>()));
  gh.singleton<_i474.AllCountriesBloc>(
      () => _i474.AllCountriesBloc(gh<_i414.PlayersRepository>()));
  gh.singleton<_i845.CountryPlayersBloc>(
      () => _i845.CountryPlayersBloc(gh<_i414.PlayersRepository>()));
  gh.singleton<_i347.StickerpacksBloc>(
      () => _i347.StickerpacksBloc(gh<_i414.PlayersRepository>()));
  gh.singleton<_i515.ConfederationsBloc>(
      () => _i515.ConfederationsBloc(gh<_i108.ConnfederationsRepository>()));
  return getIt;
}
