import 'package:flutter/material.dart';
import 'package:tp1/screens/about_screen.dart';
import 'package:tp1/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinéTime',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff363636),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) {
          return const HomeScreen(title: 'CinéTime');
        },
        '/about': (BuildContext context) {
          return const AboutScreen();
        }
      },
    );
  }
}
