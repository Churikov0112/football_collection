// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
import '../features/draft/presentation/blocs/draft_tournament_bloc/draft_tournament_bloc.dart'
    as _i1008;
import '../features/football_cards/data/football_players_repository.dart'
    as _i1065;
import '../features/football_cards/presentation/blocs/all_countries_bloc/all_countries_bloc.dart'
    as _i707;
import '../features/football_cards/presentation/blocs/all_football_cards_bloc/all_football_cards_bloc.dart'
    as _i1039;
import '../features/football_cards/presentation/blocs/all_football_players_bloc/all_football_players_bloc.dart'
    as _i110;
import '../features/football_cards/presentation/blocs/football_players_packs_bloc/football_players_packs_bloc.dart'
    as _i997;
import '../features/football_confederations/domain/repos/football_confederations_repository.dart'
    as _i47;
import '../features/football_confederations/presentation/blocs/football_confederations_bloc/football_confederations_bloc.dart'
    as _i878;
import '../features/leaderboard/presentation/blocs/leaderboard_bloc/leaderboard_bloc.dart'
    as _i1022;
import '../features/leaderboard/presentation/blocs/leaderboard_country_bloc/leaderboard_country_bloc.dart'
    as _i149;
import '../features/mini_games/presentation/blocs/balance_bloc/balance_bloc.dart'
    as _i550;
import '../services/firebase/firestore_service.dart' as _i939;
import '../services/localization/language_bloc/language_bloc.dart' as _i381;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.singleton<_i717.FirstLaunchBloc>(() => _i717.FirstLaunchBloc());
  gh.singleton<_i367.SavedCardsBloc>(() => _i367.SavedCardsBloc());
  gh.singleton<_i809.SettingsBloc>(() => _i809.SettingsBloc());
  gh.singleton<_i1065.CommonFootballRepository>(
    () => _i1065.CommonFootballRepository(),
  );
  gh.singleton<_i47.FootballConfederationsRepository>(
    () => _i47.FootballConfederationsRepository(),
  );
  gh.singleton<_i149.LeaderboardCountryBloc>(
    () => _i149.LeaderboardCountryBloc(),
  );
  gh.singleton<_i550.BalanceBloc>(() => _i550.BalanceBloc());
  gh.singleton<_i939.FirestoreService>(() => _i939.FirestoreService());
  gh.singleton<_i381.LanguageBloc>(() => _i381.LanguageBloc());
  gh.singleton<_i1039.AllFootballCardsBloc>(
    () => _i1039.AllFootballCardsBloc(
      repository: gh<_i1065.CommonFootballRepository>(),
    ),
  );
  gh.singleton<_i110.AllFootballPlayersBloc>(
    () => _i110.AllFootballPlayersBloc(
      repository: gh<_i1065.CommonFootballRepository>(),
    ),
  );
  gh.singleton<_i1008.DraftTournamentBloc>(
    () => _i1008.DraftTournamentBloc(gh<_i1065.CommonFootballRepository>()),
  );
  gh.singleton<_i707.AllCountriesBloc>(
    () => _i707.AllCountriesBloc(gh<_i1065.CommonFootballRepository>()),
  );
  gh.singleton<_i997.FootballPlayersPacksBloc>(
    () => _i997.FootballPlayersPacksBloc(gh<_i1065.CommonFootballRepository>()),
  );
  gh.singleton<_i878.FootballConfederationsBloc>(
    () => _i878.FootballConfederationsBloc(
      gh<_i47.FootballConfederationsRepository>(),
    ),
  );
  gh.singleton<_i1022.LeaderboardBloc>(
    () => _i1022.LeaderboardBloc(gh<_i939.FirestoreService>()),
  );
  return getIt;
}
