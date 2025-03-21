// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../features/albums/data/players_repository.dart' as _i385;
import '../features/albums/presentation/blocs/all_players_bloc/all_players_bloc.dart'
    as _i678;
import '../features/albums/presentation/blocs/country_players_bloc/country_players_bloc.dart'
    as _i433;
import '../features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart'
    as _i826;
import '../features/albums/presentation/blocs/stickerpacks_bloc/stickerpacks_bloc.dart'
    as _i78;
import '../features/confederations/domain/repos/confederations_repository.dart'
    as _i108;
import '../features/confederations/presentation/blocs/confederations_bloc/confederations_bloc.dart'
    as _i515;
import '../features/countries/domain/repos/countries_repository.dart' as _i71;
import '../features/countries/presentation/blocs/countries_bloc/countries_bloc.dart'
    as _i167;

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
  gh.singleton<_i71.CountriesRepository>(() => _i71.CountriesRepository());
  gh.singleton<_i385.PlayersRepository>(() => _i385.PlayersRepository());
  gh.singleton<_i826.SavedPlayersBloc>(() => _i826.SavedPlayersBloc());
  gh.singleton<_i167.CountriesBloc>(
      () => _i167.CountriesBloc(gh<_i71.CountriesRepository>()));
  gh.singleton<_i678.AllPlayersBloc>(
      () => _i678.AllPlayersBloc(repository: gh<_i385.PlayersRepository>()));
  gh.singleton<_i433.CountryPlayersBloc>(
      () => _i433.CountryPlayersBloc(gh<_i385.PlayersRepository>()));
  gh.singleton<_i78.StickerpacksBloc>(
      () => _i78.StickerpacksBloc(gh<_i385.PlayersRepository>()));
  gh.singleton<_i515.ConfederationsBloc>(
      () => _i515.ConfederationsBloc(gh<_i108.ConnfederationsRepository>()));
  return getIt;
}
