import 'package:flutter/material.dart';
import 'package:tp1/screens/about_screen.dart';
import 'package:tp1/screens/home_screen.dart';
import 'package:tp1/widget/custom_list_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) {
          return const HomeScreen(title: 'Home Page');
        },
        '/about': (BuildContext context) {
          return const AboutScreen();
        }
      },
    );
  }
}
