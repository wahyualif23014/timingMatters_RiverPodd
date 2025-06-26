// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidInit,
//     );

//     await _notificationsPlugin.initialize(initSettings);
//   }

//   static Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'channel_id',
//       'Default',
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     const NotificationDetails platformDetails =
//         NotificationDetails(android: androidDetails);

//     await _notificationsPlugin.show(id, title, body, platformDetails);
//   }
// }
