<<<<<<< HEAD
import 'package:crm/utils/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
=======
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
import 'package:crm/SignIn/splash.dart';
import 'package:crm/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  // Initialize Push Notifications
  await NotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessagingBackgroundHandler,
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],

=======

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'CRM App',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
<<<<<<< HEAD
          seedColor: const Color(0xFF26A69A),
          primary: const Color(0xFF26A69A),
=======
          seedColor: const Color(0xFF6B4195),
          primary: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          surface: Colors.white,
          background: const Color(0xFFF8F9FA),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
<<<<<<< HEAD
          backgroundColor: Color(0xFF26A69A),
=======
          backgroundColor: Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
<<<<<<< HEAD
          seedColor: const Color(0xFF26A69A),
          primary: const Color(0xFF26A69A),
=======
          seedColor: const Color(0xFF6B4195),
          primary: const Color(0xFF6B4195),
>>>>>>> 5271cc96814591a548bd1c0b01a88df5c62cd342
          brightness: Brightness.dark,
          surface: const Color(0xFF1E1E1E),
          background: const Color(0xFF121212),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.withOpacity(0.1)),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          textColor: Colors.white,
          subtitleTextStyle: TextStyle(color: Colors.white70),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
