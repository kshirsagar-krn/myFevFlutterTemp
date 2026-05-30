// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // =============================================================================
// // Background handler — MUST be top-level function (outside any class)
// // =============================================================================
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint('📩 Background message received: ${message.notification?.title}');
// }

// // =============================================================================
// // FCM Service — Singleton
// // =============================================================================
// class FCMService {
//   // ---------------------------------------------------------------------------
//   // Singleton
//   // ---------------------------------------------------------------------------
//   static final FCMService _instance = FCMService._internal();
//   factory FCMService() => _instance;
//   FCMService._internal();

//   // ---------------------------------------------------------------------------
//   // Instances
//   // ---------------------------------------------------------------------------
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // ---------------------------------------------------------------------------
//   // Android Notification Channel
//   // ---------------------------------------------------------------------------
//   static const AndroidNotificationChannel
//   _androidNotificationChannel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description:
//         'This channel is used for important notifications such as new orders and bookings.',
//     importance: Importance.high,
//     playSound: true,
//   );

//   // ---------------------------------------------------------------------------
//   // Initialize — call once in main()
//   // ---------------------------------------------------------------------------
//   Future<void> initialize() async {
//     // Step 1: Register background message handler
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

//     // Step 2: Request notification permissions
//     await _requestNotificationPermissions();

//     // Step 3: Setup local notifications
//     await _setupLocalNotifications();

//     // Step 4: Listen to foreground messages
//     _listenToForegroundMessages();

//     // Step 5: Handle notification taps
//     _handleNotificationTaps();

//     // Step 6: Initialize FCM token
//     await _initializeFCMToken();
//   }

//   // ---------------------------------------------------------------------------
//   // Step 2: Request Permissions
//   // ---------------------------------------------------------------------------
//   Future<void> _requestNotificationPermissions() async {
//     final NotificationSettings settings = await _firebaseMessaging
//         .requestPermission(
//           alert: true,
//           announcement: false,
//           badge: true,
//           carPlay: false,
//           criticalAlert: false,
//           provisional: false,
//           sound: true,
//         );

//     debugPrint(
//       '🔔 Notification permission status: ${settings.authorizationStatus}',
//     );

//     // iOS only: show notifications while app is in foreground
//     if (Platform.isIOS) {
//       await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Step 3: Setup Local Notifications
//   // ---------------------------------------------------------------------------
//   Future<void> _setupLocalNotifications() async {
//     // Create Android notification channel
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(_androidNotificationChannel);

//     // Android initialization settings
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // iOS initialization settings
//     const DarwinInitializationSettings iOSInitializationSettings =
//         DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestBadgePermission: true,
//           requestSoundPermission: true,
//         );

//     // Combined initialization settings
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: androidInitializationSettings,
//           iOS: iOSInitializationSettings,
//         );

//     // Initialize the plugin with static callback
//     await _flutterLocalNotificationsPlugin.initialize(
//       settings: initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationTapped,
//     );
//   }

//   // ---------------------------------------------------------------------------
//   // Static callback for local notification tap
//   // MUST be static — instance methods cannot be used in initialize() callback
//   // ---------------------------------------------------------------------------
//   static void _onNotificationTapped(NotificationResponse notificationResponse) {
//     debugPrint(
//       '🔔 Local notification tapped. Payload: ${notificationResponse.payload}',
//     );

//     final String? payload = notificationResponse.payload;
//     if (payload == null) return;

//     debugPrint('📦 Local notification payload: $payload');
//     // TODO: Use NavigationService to navigate based on payload
//   }

//   // ---------------------------------------------------------------------------
//   // Step 4: Listen to Foreground Messages
//   // ---------------------------------------------------------------------------
//   void _listenToForegroundMessages() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
//       debugPrint(
//         '📩 Foreground message received: ${remoteMessage.notification?.title}',
//       );
//       debugPrint('📩 Message data: ${remoteMessage.data}');

//       final RemoteNotification? notification = remoteMessage.notification;

//       if (notification != null) {
//         _showLocalNotification(
//           id: remoteMessage.hashCode,
//           title: notification.title ?? 'eSmartRestaurant',
//           body: notification.body ?? 'You have a new notification',
//           payload: remoteMessage.data.toString(),
//         );
//       }
//     });
//   }

//   // ---------------------------------------------------------------------------
//   // Step 5: Handle Notification Taps (Background & Terminated)
//   // ---------------------------------------------------------------------------
//   void _handleNotificationTaps() {
//     // Case 1: App opened from TERMINATED state by tapping notification
//     _firebaseMessaging.getInitialMessage().then((RemoteMessage? remoteMessage) {
//       if (remoteMessage != null) {
//         debugPrint(
//           '🚀 App opened from TERMINATED state: ${remoteMessage.notification?.title}',
//         );
//         _handleNotificationData(remoteMessage.data);
//       }
//     });

//     // Case 2: App opened from BACKGROUND state by tapping notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
//       debugPrint(
//         '🚀 App opened from BACKGROUND state: ${remoteMessage.notification?.title}',
//       );
//       _handleNotificationData(remoteMessage.data);
//     });
//   }

//   // ---------------------------------------------------------------------------
//   // Show Local Notification
//   // ---------------------------------------------------------------------------
//   Future<void> _showLocalNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//   }) async {
//     final AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//           _androidNotificationChannel.id,
//           _androidNotificationChannel.name,
//           channelDescription: _androidNotificationChannel.description,
//           importance: Importance.high,
//           priority: Priority.high,
//           playSound: true,
//           icon: '@mipmap/ic_launcher',
//           styleInformation: BigTextStyleInformation(body),
//         );

//     const DarwinNotificationDetails iOSNotificationDetails =
//         DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         );

//     final NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: iOSNotificationDetails,
//     );

//     await _flutterLocalNotificationsPlugin.show(
//       id: id,
//       title: title,
//       body: body,
//       notificationDetails: notificationDetails,
//       payload: payload,
//     );
//   }

//   // ---------------------------------------------------------------------------
//   // Handle Notification Data — Navigate based on type
//   // ---------------------------------------------------------------------------
//   void _handleNotificationData(Map<String, dynamic> data) {
//     debugPrint('📦 Handling notification data: $data');

//     final String? type = data['type'];

//     switch (type) {
//       case 'order':
//         final String? orderId = data['orderId'];
//         debugPrint('📦 Navigate to Order screen. Order ID: $orderId');
//         // TODO: NavigationService.navigateTo(OrderScreen(orderId: orderId));
//         break;

//       case 'booking':
//         final String? bookingId = data['bookingId'];
//         debugPrint('📅 Navigate to Booking screen. Booking ID: $bookingId');
//         // TODO: NavigationService.navigateTo(BookingScreen(bookingId: bookingId));
//         break;

//       case 'new_order':
//         debugPrint('🆕 New order received. Navigate to Active Orders.');
//         // TODO: NavigationService.navigateTo(ActiveOrdersScreen());
//         break;

//       default:
//         debugPrint('🔔 General notification. Type: $type');
//         break;
//     }
//   }

//   // ---------------------------------------------------------------------------
//   // Step 6: FCM Token
//   // ---------------------------------------------------------------------------
//   Future<void> _initializeFCMToken() async {
//     final String? token = await _firebaseMessaging.getToken();
//     debugPrint('🔑 FCM Token: $token');

//     // TODO: Send this token to your backend
//     // await AuthRepo().saveFCMToken(token);

//     // Listen for token refresh
//     _firebaseMessaging.onTokenRefresh.listen((String newToken) {
//       debugPrint('🔄 FCM Token refreshed: $newToken');
//       // TODO: Send updated token to your backend
//       // await AuthRepo().saveFCMToken(newToken);
//     });
//   }

//   // ---------------------------------------------------------------------------
//   // Public Methods
//   // ---------------------------------------------------------------------------

//   /// Get FCM token — call after login to send token to backend
//   Future<String?> getToken() async {
//     return await _firebaseMessaging.getToken();
//   }

//   /// Delete FCM token — call on logout
//   Future<void> deleteToken() async {
//     await _firebaseMessaging.deleteToken();
//     debugPrint('🗑️ FCM Token deleted');
//   }

//   /// Subscribe to a topic
//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//     debugPrint('✅ Subscribed to topic: $topic');
//   }

//   /// Unsubscribe from a topic
//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//     debugPrint('❌ Unsubscribed from topic: $topic');
//   }
// }
