import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loker/bloc/auth/auth_bloc.dart';
import 'package:loker/bloc/category/category_bloc.dart';
import 'package:loker/bloc/interview/interview_bloc.dart';
import 'package:loker/bloc/loker/loker_bloc.dart';
import 'package:loker/bloc/navbar/navbar_bloc.dart';
import 'package:loker/bloc/notifikasi/notifikasi_bloc.dart';
import 'package:loker/pages/splash/splash.dart';
import 'package:loker/repositories/auth/auth_repository.dart';
import 'package:loker/repositories/category/category_repository.dart';
import 'package:loker/repositories/interview/interview_repositry.dart';
import 'package:loker/repositories/loker/loker_repository.dart';
import 'package:loker/repositories/notifikasi/notifikasi_repository.dart';
import 'package:loker/repositories/seleksi/seleksi_repository.dart';
import 'package:loker/services/shared_preferences_services.dart';
import 'package:sizer/sizer.dart';

import 'bloc/seleksi/seleksi_bloc.dart';
import 'bloc/splash/splash_bloc.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ),
    );
  }
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  await SharedPreferencesService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(SplashToHome())),
        BlocProvider<NavbarBloc>(create: (context) => NavbarBloc()),
        BlocProvider(
          create: (context) => AuthBloc(Authrepository()),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(CategoryRepository()),
        ),
        BlocProvider(
          create: (context) => LokerBloc(LokerRepository()),
        ),
        BlocProvider(
          create: (context) => NotifikasiBloc(NotifikasiRepository()),
        ),
        BlocProvider(
          create: (context) => SeleksiBloc(SeleksiRepository()),
        ),
        BlocProvider(
          create: (context) => InterviewBloc(InterviewRepository()),
        )
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}
