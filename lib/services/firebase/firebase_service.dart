import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../../firebase_options.dart';
import '../navigation/navigation.dart';

const _kPushDeeplinkKey = 'link';
final FlutterLocalNotificationsPlugin flutterLocalNotifications = FlutterLocalNotificationsPlugin();

class FirebaseService {
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    debugPrint("Handling a background message: ${message.messageId}");
    debugPrint('Message data: ${message.data}');
    debugPrint('Message notification title: ${message.notification?.title}');
    debugPrint('Message notification body: ${message.notification?.body}');
  }

  static Future<void> init() async {
    final firebaseAppName = Platform.isIOS ? "football-collection" : null;
    await Firebase.initializeApp(
      name: firebaseAppName,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestNotificationPermission();

    await getToken();

    // для навигации нужен контекст
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 330));
      await _setup();
      debugPrint('Firebase initialized');
    });
  }

  // If the application has been opened from a terminated state
  static Future<void> _setupInitialMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen

    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleInitialMessage(RemoteMessage message) {
    final deeplink = message.data[_kPushDeeplinkKey];
    _openDeeplink(deeplink);
  }

  static Future<void> _requestNotificationPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('Permission granted: ${settings.authorizationStatus}');
  }

  static Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("firebase token $token");
    if (token != null) {
      // await Clipboard.setData(ClipboardData(text: token));
    }
    return token;
  }

  static Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  static Future<void> _setup() async {
    await _setupForegroundMessages();
    await _setupOnMessageOpenedApp();
    await _setupInitialMessage();
    await _setupInitialTopics();
  }

  static Future<void> _setupInitialTopics() async {
    await subscribeToTopic("main");
    await subscribeToTopic("info");
    await subscribeToTopic("test");
  }

  static Future<void> _setupForegroundMessages() async {
    if (Platform.isAndroid) {
      await _setupForegroundMessagesForAndroid();
    } else if (Platform.isIOS) {
      await _setupForegroundMessagesForIos();
    }
  }

  // if the app has opened from a background state (not terminated).
  // ios while app open
  // ios while app in background
  // android while app in background
  static Future<void> _setupOnMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final deeplink = message.data[_kPushDeeplinkKey];
      _openDeeplink(deeplink);
    });
  }

  // android while app open
  static void _onMessageTapAndroid(
    NotificationResponse response,
  ) {
    if (response.payload != null) {
      final deeplink = (jsonDecode(response.payload!) as Map<dynamic, dynamic>)[_kPushDeeplinkKey];
      _openDeeplink(deeplink);
    }
  }

  static Future<void> _setupForegroundMessagesForAndroid() async {
    const channel = AndroidNotificationChannel(
      'world_cup_collection_2026', // id
      'world_cup_collection_2026', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    // final bitmap = (await rootBundle.load('assets/raster/logo.png')).buffer.asUint8List();

    await flutterLocalNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onMessageTapAndroid,
      onDidReceiveBackgroundNotificationResponse: _onMessageTapAndroid,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotifications.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'ic_notification',
              // largeIcon: ByteArrayAndroidBitmap(bitmap),
              priority: Priority.max,
              importance: Importance.max,
              enableVibration: true,
              fullScreenIntent: true,
            ),
          ),
          payload: json.encode(message.data),
        );
      }
    });
  }

  static Future<void> _setupForegroundMessagesForIos() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: false,
    );
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<dynamic, dynamic>? data,
  }) async {
    // final bitmap = (await rootBundle.load('assets/raster/logo.png')).buffer.asUint8List();
    await flutterLocalNotifications.show(
      id: Random().nextInt(999999),
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          "world_cup_collection_2026",
          "world_cup_collection_2026",
          // largeIcon: ByteArrayAndroidBitmap(bitmap),
          priority: Priority.max,
          importance: Importance.max,
          enableVibration: true,
          fullScreenIntent: true,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: json.encode(data),
    );
  }

  static void _openDeeplink(String? deeplink) {
    if (deeplink == null) {
      return;
    }
    rootNavigatorKey.currentContext?.go(deeplink);
  }
}
