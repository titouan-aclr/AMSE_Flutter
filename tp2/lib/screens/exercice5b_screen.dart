import 'package:flutter/material.dart';
import 'package:tp2/utils/utils.dart';

class Exercice5bScreen extends StatelessWidget {
  const Exercice5bScreen({super.key});

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
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(2.5),
                color: getRandomColor(),
                child: Center(child: Text("Tile $index")),
              );
            },
          ),
        ),
      ),
    );
  }
}
