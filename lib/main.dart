import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'providers/quiz_provider.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart'; // Pastikan sudah ada
import 'screens/home_screen.dart';     // Pastikan sudah ada
import 'screens/quiz_screen.dart';    // Pastikan sudah ada
import 'screens/result_screen.dart';  // Pastikan sudah ada
import 'screens/leaderboard_screen.dart'; // Pastikan sudah ada
import 'screens/profile_screen.dart'; // Tambah import untuk ProfileScreen

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Set ke false jika kamu menjalankan di emulator/perangkat fisik
      builder: (context) => ChangeNotifierProvider(
        create: (context) => QuizProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizaja',
      useInheritedMediaQuery: true, // Diperlukan untuk DevicePreview
      locale: DevicePreview.locale(context), // Diperlukan untuk DevicePreview
      builder: DevicePreview.appBuilder, // Diperlukan untuk DevicePreview
      theme: ThemeData(
        primarySwatch: Colors.teal, // Ubah ke teal agar sesuai dengan tema
        scaffoldBackgroundColor: Colors.transparent, // Biar gradient background terlihat
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[400],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/login', // Ganti home dengan initialRoute untuk mendukung navigasi berbasis rute
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/quiz': (context) => QuizScreen(),
        '/result': (context) => ResultScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/profile': (context) => ProfileScreen(), // Tambah rute untuk ProfileScreen
      },
    );
  }
}