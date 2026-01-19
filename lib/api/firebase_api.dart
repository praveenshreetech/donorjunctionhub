import 'dart:convert';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

final localNotification = FlutterLocalNotificationsPlugin();

final androidChannel = const AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications',
  importance: Importance.defaultImportance,
);

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint("Title: ${message.notification!.title}");
  debugPrint("Body: ${message.notification!.body}");
  debugPrint("Payload: ${message.data}");
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  Get.toNamed(AppRouters.bottombar);
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;
    localNotification.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            androidChannel.id, androidChannel.name,
            channelDescription: androidChannel.description, playSound: true),
      ),
      payload: jsonEncode(message.toMap()),
    );
  });
}

Future initLocalNotifications() async {
  const settings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
      iOS: DarwinInitializationSettings());
  await localNotification.initialize(
    settings,
  );
  final platform = localNotification.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(androidChannel);
}

class FirebaseApi {
  final firebasemessaging = FirebaseMessaging.instance;

  Future<String> initNotifications() async {
    await firebasemessaging.requestPermission();
    final fcmToken = await firebasemessaging.getToken();
    initPushNotifications();
    initLocalNotifications();
    return fcmToken ?? "";
  }
}
