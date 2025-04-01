import 'package:flutter/material.dart';
import 'package:football_collection/features/confederations/domain/models/confederation.dart';
import 'package:football_collection/features/confederations/presentation/screens/regions_screen/confederations_screen.dart';
import 'package:football_collection/features/mini_games/presentation/screens/guess_transfer_value_screen/guess_transfer_value_screen.dart';
import 'package:football_collection/features/mini_games/presentation/screens/mini_games_screen/mini_games_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/countries/domain/models/country.dart';
import '../../features/countries/presentation/screens/countries_screen/countries_screen.dart';
import '../../features/mini_games/presentation/screens/guess_transfer_value_less_more_screen/guess_transfer_value_less_more_screen.dart';
import '../../features/players/presentation/screens/album/players_screen.dart';
import '../../features/players/presentation/screens/open_pack_screen/open_pack_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class RoutePaths {
  static const confederations = '/confederations';
  static const countries = '/countries';
  static const album = '/album';
  static const stickerpack = '/stickerpack';

  // minigames
  static const miniGames = '/miniGames';
  static const miniGameGuessTransferValue = '/miniGameGuessTransferValue';
  static const miniGameGuessTransferValueLessMore = '/miniGameGuessTransferValueLessMore';

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

  factory FootballCollectionRouter(String initialRoute) {
    _inst.router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: RoutePaths.album,
          builder: (context, state) => PlayersScreen(
            country: state.extra as CountryModel,
          ),
        ),
        GoRoute(
          path: RoutePaths.stickerpack,
          builder: (context, state) => OpenPackScreen(
            args: state.extra as OpenPackScreenArgs,
          ),
        ),
        GoRoute(
          path: RoutePaths.confederations,
          builder: (context, state) => const ConfederationsScreen(),
        ),
        GoRoute(
          path: RoutePaths.countries,
          builder: (context, state) => CountriesScreen(
            confederation: state.extra as Confederations,
          ),
        ),
        GoRoute(
          path: RoutePaths.miniGames,
          builder: (context, state) => MiniGamesScreen(),
        ),
        GoRoute(
          path: RoutePaths.miniGameGuessTransferValue,
          builder: (context, state) => GuessTransferValueScreen(),
        ),
        GoRoute(
          path: RoutePaths.miniGameGuessTransferValueLessMore,
          builder: (context, state) => GuessTransferValueLessMoreScreen(),
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
