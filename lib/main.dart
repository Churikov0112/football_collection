import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

import 'config/toastification.dart';
import 'di/di.dart';
import 'services/navigation/navigation.dart';
import 'ui_kit/ui_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );

  runApp(const FootballPackCollectionApp());
}

class FootballPackCollectionApp extends StatefulWidget {
  const FootballPackCollectionApp({super.key});

  @override
  State<FootballPackCollectionApp> createState() => _FootballPackCollectionAppState();
}

class _FootballPackCollectionAppState extends State<FootballPackCollectionApp> {
  late FootballCollectionRouter _router;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  bool isInitialized = false;
  bool isLogged = false;

  Future<void> initializeApp() async {
    await configureDependencies();
    await getIt.allReady();

    setState(() {});

    // final authBloc = getIt.get<AuthBloc>();
    // final authProcessingBloc = getIt.get<AuthProcessingBloc>();

    // bool isLogged = false;

    // if (authBloc.state is AuthStateAuthorized) {
    //   final session = (authBloc.state as AuthStateAuthorized).session;

    //   // if (session.expireAt.isBefore(DateTime.now()) || session.expireAt.difference(DateTime.now()).abs().inDays < 3) {
    //   authProcessingBloc.add(AuthProcessingEventSessionRefresh(refreshToken: session.refreshToken));

    //   final state = await authProcessingBloc.stream.firstWhere((element) {
    //     return element is AuthProcessingStateSessionRefreshedSuccessfully ||
    //         element is AuthProcessingStateSessionRefreshFailed;
    //   });

    //   if (state is AuthProcessingStateSessionRefreshedSuccessfully) {
    //     authBloc.add(AuthEventSetSession(state.session));
    //     isLogged = true;
    //   } else {
    //     authBloc.add(const AuthEventReset());
    //   }
    // }

    // TODO remove after auth done
    isLogged = true;

    setState(() {
      isInitialized = true;
    });

    _router = FootballCollectionRouter(isLogged ? RoutePaths.confederations : RoutePaths.confederations);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return !isInitialized
        ? const SizedBox.shrink()
        : ToastificationWrapper(
            config: toastificationConfig,
            child: MaterialApp.router(
              routerConfig: _router.router,
              title: 'Football Pack Collection',
              color: Colors.black,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return child == null
                    ? const SizedBox.shrink()
                    : ScrollConfiguration(
                        behavior: DisableBlueGlowBehavior(),
                        child: AnnotatedRegion(
                          value: const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
                          child: MediaQuery.withNoTextScaling(
                            child: child,
                          ),
                        ),
                      );
              },
            ),
          );
  }
}
