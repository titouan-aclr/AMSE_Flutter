import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exercice1 extends StatefulWidget {
  const Exercice1({super.key});

  @override
  State<Exercice1> createState() => _Ex1ScreenState();
}

class _Ex1ScreenState extends State<Exercice1> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Exercice 1"),
      ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('https://picsum.photos/512/1024.jpg', width: screenWidth, height: screenHeight),
        ));


    //throw UnimplementedError();
  }
}
