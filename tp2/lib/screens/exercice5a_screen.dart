import 'package:flutter/material.dart';
import 'package:tp2/utils/utils.dart';

class Exercice5aScreen extends StatelessWidget {
  const Exercice5aScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GridView from count example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: <Widget>[
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 1")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 2")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 3")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 4")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 5")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 6")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 7")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 8")),
              ),
              Container(
                color: getRandomColor(),
                child: const Center(child: Text("Tile 9")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
