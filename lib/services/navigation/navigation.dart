import 'package:flutter/material.dart';
import 'package:football_collection/features/football_confederations/presentation/screens/confederations_screen/football_confederations_screen.dart';
import 'package:football_collection/features/mini_games/presentation/screens/guess_transfer_value_screen/guess_transfer_value_screen.dart';
import 'package:football_collection/features/mini_games/presentation/screens/mini_games_screen/mini_games_screen.dart';
import 'package:football_collection/features/onboarding/presentation/screens/onboarding_screen/onboarding_screen.dart';
import 'package:football_collection/features/settings/presentation/ui/screens/settings_screen/settings_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/countries/domain/models/country.dart';
import '../../features/countries/presentation/screens/countries_screen/countries_screen.dart';
import '../../features/football_confederations/domain/models/football_confederation.dart';
import '../../features/football_players/presentation/screens/album_screen/football_players_album_screen.dart';
import '../../features/football_players/presentation/screens/packs_screen/football_players_packs_screen.dart';
import '../../features/mini_games/presentation/screens/guess_who_is_more_expensive_screen/guess_who_is_more_expensive_screen.dart';
import '../../features/qr/presentation/screens/get_card_by_qr_screen/get_card_by_qr_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class RoutePaths {
  static const onboarding = '/onboarding';

  static const footballConfederations = '/footballConfederations';
  static const footballCountries = '/footballCountries';
  static const footballPlayersAlbum = '/footballPlayersAlbum';
  static const footballPlayersPacks = '/footballPlayersPacks';

  // minigames
  static const miniGames = '/miniGames';
  static const footballMiniGameGuessTransferValue = '/footballMiniGameGuessTransferValue';
  static const footballMiniGameGuessWhoIsMoreExpensive = '/footballMiniGameGuessWhoIsMoreExpensive';

  static const getCardByQr = '/getCardByQr';
  static const settings = '/settings';

  // static const main = '/main';
  // static const auth = '/auth';
  // static const map = '/map';
  // static const profile = '/profile';
  // static const tickets = '/tickets';
  // static const mediaGalleryFullScreen = '/mediaGalleryFullScreen';
  // static const qrScanner = '/qrScanner';
  // static const paymentWebview = '/paymentWebview';
}

class FootballCollectionRouter {
  late GoRouter router;

  static final FootballCollectionRouter _inst = FootballCollectionRouter._internal();

  Page<T> buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.25, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  factory FootballCollectionRouter(String initialRoute) {
    _inst.router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: RoutePaths.footballPlayersAlbum,
          builder: (context, state) => FootballPlayersAlbumScreen(
            country: state.extra as CountryModel,
          ),
        ),
        GoRoute(
          path: RoutePaths.footballPlayersPacks,
          builder: (context, state) => FootballPlayersPacksScreen(
            args: state.extra as FootballPlayersPacksScreenArgs,
          ),
        ),
        GoRoute(
          path: RoutePaths.footballConfederations,
          builder: (context, state) => const FootballConfederationsScreen(),
        ),
        GoRoute(
          path: RoutePaths.footballCountries,
          builder: (context, state) => FootballCountriesScreen(
            confederation: state.extra as FootballConfederations,
          ),
        ),
        GoRoute(
          path: RoutePaths.miniGames,
          builder: (context, state) => MiniGamesScreen(),
        ),
        GoRoute(
          path: RoutePaths.footballMiniGameGuessTransferValue,
          builder: (context, state) => GuessTransferValueScreen(),
        ),
        GoRoute(
          path: RoutePaths.footballMiniGameGuessWhoIsMoreExpensive,
          builder: (context, state) => GuessWhichFootballPlayerIsMoreExpensiveScreen(),
        ),
        GoRoute(
          path: RoutePaths.getCardByQr,
          builder: (context, state) => GetCardByQrScreen(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          builder: (context, state) => SettingsScreen(),
        ),
        GoRoute(
          path: RoutePaths.onboarding,
          builder: (context, state) => OnboardingScreen(),
        ),

        // GoRoute(
        //   path: RoutePaths.main,
        //   builder: (context, state) => const MainScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.map,
        //   builder: (context, state) => const MapScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.auth,
        //   builder: (context, state) => const AuthScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.profile,
        //   builder: (context, state) => const ProfileScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.tickets,
        //   builder: (context, state) => const TicketsScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.sandbox,
        //   builder: (context, state) => const SandboxScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.qrScanner,
        //   builder: (context, state) => const QrScannerScreen(),
        // ),
        // GoRoute(
        //   path: RoutePaths.mediaGalleryFullScreen,
        //   pageBuilder: (context, state) => buildMenuPageWithDefaultTransition(
        //     context: context,
        //     state: state,
        //     child: MediaGalleryFullScreen(
        //       args: state.extra as MediaGalleryFullScreenArguments,
        //     ),
        //   ),
        // ),
        // GoRoute(
        //   path: RoutePaths.paymentWebview,
        //   builder: (context, state) => PaymentWebviewScreen(
        //     args: state.extra as PaymentWebViewScreenArgs,
        //   ),
        // ),
      ],
    );

    return _inst;
  }

  FootballCollectionRouter._internal();
}
