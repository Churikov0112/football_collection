import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:football_collection/features/abstract/presentation/blocs/first_launch_bloc/first_launch_bloc.dart';
import 'package:football_collection/firebase_options.dart';
import 'package:football_collection/services/firebase/firebase_methods.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/localization/language_bloc/language_bloc.dart';
import 'package:football_collection/services/log/log_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

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
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  try {
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
  } catch (e) {
    LogService.error(e.toString(), e);
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(systemNavigationBarColor: Colors.black, statusBarColor: Colors.transparent),
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
    isLogged = true;
    isInitialized = true;
    setState(() {});
    final isFirstLaunch = getIt.get<FirstLaunchBloc>().state.isFirstLaunch ?? true;

    _router = FootballCollectionRouter(isFirstLaunch ? RoutePaths.onboarding : RoutePaths.home);

    try {
      MobileAds.setUserConsent(true);
      MobileAds.setAgeRestrictedUser(true);
      MobileAds.initialize();
    } catch (e) {
      LogService.error(e.toString(), e);
    }

    try {
      await Future.delayed(const Duration(milliseconds: 330), () {
        setupInteractedMessage();
      });
    } catch (e) {
      LogService.error(e.toString(), e);
    }
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
                  theme: ThemeData.dark().copyWith(colorScheme: ColorScheme.dark(primary: Colors.deepOrange)),
                  routerConfig: _router.router,
                  title: 'Football Collection 2025',
                  color: Colors.black,
                  debugShowCheckedModeBanner: true,
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
                                child: SafeArea(top: false, bottom: true, child: child),
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
