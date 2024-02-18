import 'package:flutter/material.dart';
import 'package:tp2/utils/utils.dart';

// ==============
// Models
// ==============

class Tile {
  late Color color;
  late String label;

  Tile(this.color, this.label);
  Tile.randomColor() {
    color = getRandomColor();
  }
  Tile.setLabel(this.label);
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;
  const TileWidget({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      color: tile.color,
      child: Center(child: Text(tile.label)),
    );
  }
}

class Exercice6bScreen extends StatefulWidget {
  const Exercice6bScreen({super.key});

  @override
  State<Exercice6bScreen> createState() => _Exercice6aScreenState();
}

class _Exercice6aScreenState extends State<Exercice6bScreen> {
  List<Widget> tiles = List<Widget>.generate(
      8,
      (index) =>
          TileWidget(tile: Tile(Colors.grey, "Tile ${index.toString()}")));
  TileWidget emptyTile = TileWidget(tile: Tile(Colors.white, "Empty"));
  int emptyPosition = 1;

  @override
  void initState() {
    tiles.insert(emptyPosition, emptyTile);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Invert two tiles"),
      ),
      body: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: swapTiles(index),
            child: tiles[index],
          );
        },
      ),
    );
  }

  swapTiles(int index) {
    /*setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });*/
    print(index);
    if (index == emptyPosition - 1 || index == emptyPosition + 1) {
      print(tiles[index]);
    } else {
      print("wrong");
    }
  }
}
