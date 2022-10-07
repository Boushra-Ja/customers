import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetailes() async => const NotificationDetails(
    android: AndroidNotificationDetails(
        "channel id", "channel name",
        channelDescription: "channel description",
        importance: Importance.max,
        icon: "@mipmap/ic_launcher",
        playSound: true),
    iOS: IOSNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final ios = IOSInitializationSettings();
    final setting = InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(
      setting,
      onSelectNotification: (payload) async {
        onNotifications.add("hazabo");
      },
    );
  }

  static Future showNotification({int id = 0, String? payload, String? title, String? body,}) async =>
      _notifications.show(id, title, body, await _notificationDetailes(),
          payload: payload);



}
