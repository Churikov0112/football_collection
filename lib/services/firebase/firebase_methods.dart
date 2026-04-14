import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:football_collection/services/localization/dictionary.dart';
import 'package:football_collection/services/log/log_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class FirebaseStaticMethods {
  static Future<void> requestNotificationPermission() async {
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
      LogService.log("Firebase token: $token");
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

  static void initInfo(Languages language) {
    _setupForegroundMessages();
    _setupOnMessageOpenedApp();
    FirebaseMessaging.instance.subscribeToTopic(language.englishName);
  }

  static Future<void> _setupForegroundMessages() async {
    if (Platform.isAndroid) {
      await _setupForegroundMessagesForAndroid();
    } else if (Platform.isIOS) {
      await _setupForegroundMessagesForIos();
    }
  }

  // ios while app open
  // ios while app in background
  // android while app in background
  static Future<void> _setupOnMessageOpenedApp() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // final notification = message.notification;

      //   if (notification != null &&
      //       message.data["screen"] != null &&
      //       message.data["click_action"] == "FLUTTER_NOTIFICATION_CLICK") {
      //     if (message.data["screen"] == "/benefits_and_season_tickets") {
      //       rootNavigatorKey.currentState?.push(
      //         MaterialPageRoute(
      //           builder: (context) => const BenefitsAndAbonementsScreen(),
      //         ),
      //       );
      //     }

      //     if (message.data["screen"] == "/notification") {
      //       getIt.get<NotificationsBloc>().add(NotificationsEventSaveFromPush(message.data));
      //       rootNavigatorKey.currentState?.push(
      //         MaterialPageRoute(
      //           builder: (context) => NotificationScreen(
      //             notification: NotificationModel(
      //               id: FwdId.fromString(message.data['notification_id']),
      //               insertedAt: DateTime.now(),
      //               text: message.data['body'],
      //               viewed: false,
      //               title: message.data['title'],
      //             ),
      //           ),
      //         ),
      //       );
      //     }
      //   }
    });
  }

  // android while app open
  static void _onMessageTapAndroid(NotificationResponse response) {
    if (response.payload != null) {
      // final data = jsonDecode(response.payload!) as Map<dynamic, dynamic>;
      // if (data["screen"] != null && data["click_action"] == "FLUTTER_NOTIFICATION_CLICK") {
      //   if (data["screen"] == "/benefits_and_season_tickets") {
      //     rootNavigatorKey.currentState?.push(
      //       MaterialPageRoute(
      //         builder: (context) => const BenefitsAndAbonementsScreen(),
      //       ),
      //     );
      //   }
      //   if (data["screen"] == "/notification") {
      //     getIt.get<NotificationsBloc>().add(NotificationsEventSaveFromPush(data));
      //     rootNavigatorKey.currentState?.push(
      //       MaterialPageRoute(
      //         builder: (context) => NotificationScreen(
      //           notification: NotificationModel(
      //             id: FwdId.fromString(data['notification_id']),
      //             insertedAt: DateTime.now(),
      //             text: data['body'],
      //             viewed: false,
      //             title: data['title'],
      //           ),
      //         ),
      //       ),
      //     );
      //   }
      // }
    }
  }

  static Future<void> _setupForegroundMessagesForAndroid() async {
    const channel = AndroidNotificationChannel(
      'football_collection', // id
      'football_collection', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    // final bitmap = (await rootBundle.load('assets/raster/icon/icon.png')).buffer.asUint8List();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_notification')),
      onDidReceiveNotificationResponse: _onMessageTapAndroid,
      onDidReceiveBackgroundNotificationResponse: _onMessageTapAndroid,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          id: notification.hashCode,
          title: notification.title,
          body: notification.body,
          notificationDetails: NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
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

  static Future<void> sendNotification(String token, String title, String body) async {
    // ПРимер запроса через Postman
    //     {
    //     "message":{
    //         "android": {
    //             "priority": "HIGH"
    //         },
    //         "data": {
    //                 "body": "Нажмите, чтобы его просмотреть",
    //                 "title": "У вас есть парковочное разрешение",
    //                 "click_action": "FLUTTER_NOTIFICATION_CLICK",
    //                 "status": "done",
    //                 "screen": "/benefits_and_season_tickets"
    //             },
    //         "notification": {
    //                 "body": "Нажмите, чтобы его просмотреть",
    //                 "title": "У вас есть парковочное разрешение"
    //                 // "android_channel_id": "dbfood",
    //                 // "sound": "default"
    //             },
    //         "token": "dS0I7PalTHmFNofvcTMQFg:APA91bHeGqDRs8OZkkQJj8sXR6v2lOUuwTSvsjAEoihuzEtp7VpFxRLe0OE37S-kPyP4wtVj6pjuskAlbEz2_T6frAoNgkZxvRe2HSn4izUZ2cCS-mNtqtasv8eQgqpYO-WuqvwCdUOo"
    //         // "token": "daSwARjVTxu48dH1OfGGt0:APA91bEQS3b3gdjaUB83uSpbioJ907TaXEFp4ZGeGSAecsx1muEe31ae-libn4qf63f-QN1se3aN-NL_5USh_-nY5T9fV4DYNSVhifsOTE0RWzF0NRmzncdf8IH0S7pPe2jCoOixzJn9"
    //     }
    // }
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
    Map<dynamic, dynamic>? data,
  }) async {
    // final bitmap = (await rootBundle.load('assets/raster/icon/icon.png')).buffer.asUint8List();

    await flutterLocalNotificationsPlugin.show(
      id: Random().nextInt(999999),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          "football_collection",
          "football_collection",
          // largeIcon: ByteArrayAndroidBitmap(bitmap),
          priority: Priority.max,
          importance: Importance.max,
          enableVibration: true,
          fullScreenIntent: true,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: json.encode(data),
    );
  }
}
