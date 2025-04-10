import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:football_collection/firebase_options.dart';
import 'package:football_collection/services/firebase/firebase_methods.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/localization/language_bloc/language_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';

import 'config/toastification.dart';
import 'di/di.dart';
import 'services/navigation/navigation.dart';
import 'ui_kit/ui_kit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification title: ${message.notification?.title}');
  debugPrint('Message notification body: ${message.notification?.body}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );

  // final firebaseAppName = Platform.isIOS ? "parking_spb_app" : null;
  await Firebase.initializeApp(
    // name: firebaseAppName,
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseStaticMethods.requestNotificationPermission();
  await FirebaseStaticMethods.getToken();
  final defaultLanguage = Languages.english;
  FirebaseStaticMethods.initInfo(defaultLanguage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const FootballPackCollectionApp()));
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

    _router = FootballCollectionRouter(
      isLogged ? RoutePaths.footballConfederations : RoutePaths.footballConfederations,
    );

    await Future.delayed(const Duration(milliseconds: 330), () {
      setupInteractedMessage();
    });
  }

  Future<void> setupInteractedMessage() async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _handleMessage(RemoteMessage message) {
    // if (message.data['screen'] == RoutePaths. '/benefits_and_season_tickets') {
    //   rootNavigatorKey.currentState?.push(
    //     MaterialPageRoute(
    //       builder: (context) => const BenefitsAndAbonementsScreen(),
    //     ),
    //   );
    // }

    // if (message.data['screen'] == '/notification') {
    //   getIt.get<NotificationsBloc>().add(NotificationsEventSaveFromPush(message.data));

    //   rootNavigatorKey.currentState?.push(
    //     MaterialPageRoute(
    //       builder: (context) => NotificationScreen(
    //         notification: NotificationModel(
    //           id: FwdId.fromString(message.data['notification_id']),
    //           insertedAt: DateTime.now(),
    //           text: message.data['body'],
    //           viewed: false,
    //           title: message.data['title'],
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return !isInitialized
        ? const SizedBox.shrink()
        : BlocBuilder<LanguageBloc, LanguageState>(
            bloc: getIt.get(),
            builder: (context, languageState) {
              return ToastificationWrapper(
                config: toastificationConfig,
                child: MaterialApp.router(
                  theme: ThemeData.dark(),
                  routerConfig: _router.router,
                  title: 'Football Pack Collection',
                  color: Colors.black,
                  debugShowCheckedModeBanner: false,
                  locale: languageState.language.locale,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: Languages.values.map((e) => e.locale).toList(),
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
            },
          );
  }
}
