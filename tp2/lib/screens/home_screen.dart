import 'package:flutter/material.dart';
import 'package:tp2/model/exercice_model.dart';
import 'package:tp2/widgets/menu_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: exercices.length,
        itemBuilder: (BuildContext context, int index) {
          return MenuTile(exercice: exercices[index]);
        },
      ),
    );
  }
}
