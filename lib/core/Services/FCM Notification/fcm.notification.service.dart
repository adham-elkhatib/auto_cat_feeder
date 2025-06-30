import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../Notification/notification.service.dart';

// The FCM server endpoint
const String fcmServerEndpoint = 'https://fcm.googleapis.com/fcm/send';

// Your Firebase Cloud Messaging server key
const String fcmServerKey = 'YOUR_SERVER_KEY_HERE';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Payload: ${message.data}");
  NotificationService.showBasic(
    message.notification?.title ?? "",
    message.notification?.body ?? "",
  );
}

class FCMNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? _fcmToken;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    _fcmToken = await _firebaseMessaging.getToken();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        final title = message.notification?.title;
        final body = message.notification?.body;
        NotificationService.showBasic(title ?? "", body ?? "", id: 0);
      },
    );
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> sendPushNotification({
    required String title,
    required String body,
    String? recipientFcmToken,
    String? topic,
  }) async {
    if (recipientFcmToken == null && topic == null) {
      print("Error: No recipient or topic specified.");
      return;
    }

    final Map<String, dynamic> notificationPayload = {
      'notification': {
        'title': title,
        'body': body,
      },
      if (recipientFcmToken != null) 'to': recipientFcmToken,
      if (topic != null) 'to': '/topics/$topic',
    };

    final http.Response response = await http.post(
      Uri.parse(fcmServerEndpoint),
      headers: {
        'Authorization': 'key=$fcmServerKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(notificationPayload),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully!');
    } else {
      print('Error sending notification: ${response.statusCode}');
    }
  }

  // Static function to access the token globally
  static String? getFcmToken() {
    return _fcmToken;
  }
}
