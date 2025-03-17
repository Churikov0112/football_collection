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
import '../features/albums/presentation/blocs/saved_players_bloc/saved_players_bloc.dart'
    as _i826;
import '../features/countries/domain/repos/countries_repository.dart' as _i71;
import '../features/countries/presentation/blocs/countries_bloc/countries_bloc.dart'
    as _i167;
import '../features/regions/domain/repos/regions_repository.dart' as _i297;
import '../features/regions/presentation/blocs/regions_bloc/regions_bloc.dart'
    as _i610;

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
  gh.singleton<_i826.SavedPlayersBloc>(() => _i826.SavedPlayersBloc());
  gh.singleton<_i297.RegionsRepository>(() => _i297.RegionsRepository());
  gh.singleton<_i167.CountriesBloc>(() => _i167.CountriesBloc());
  gh.singleton<_i385.PlayersRepository>(() => _i385.PlayersRepository());
  gh.singleton<_i71.CountriesRepository>(() => _i71.CountriesRepository());
  gh.singleton<_i610.RegionsBloc>(
      () => _i610.RegionsBloc(gh<_i297.RegionsRepository>()));
  gh.singleton<_i678.AllPlayersBloc>(
      () => _i678.AllPlayersBloc(repository: gh<_i385.PlayersRepository>()));
  return getIt;
}
