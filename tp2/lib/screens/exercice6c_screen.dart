import 'dart:math';

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
      color: tile.color,
      child: Center(child: Text(tile.label)),
    );
  }
}

class Exercice6cScreen extends StatefulWidget {
  const Exercice6cScreen({super.key});

  @override
  State<Exercice6cScreen> createState() => _Exercice6cScreenState();
}

class _Exercice6cScreenState extends State<Exercice6cScreen> {
  int nbColumns = 3;
  late int itemCount = 9;
  int indexEmpty = 1;
  late List<Widget> tiles;
  TileWidget emptyTile = TileWidget(tile: Tile(Colors.white, "Empty"));

  @override
  void initState() {
    tiles = List<Widget>.generate(
        itemCount - 1,
        (index) =>
            TileWidget(tile: Tile(Colors.grey, "Tile ${index.toString()}")));
    tiles.insert(indexEmpty, emptyTile);
    super.initState();
  }

  void populateList() {
    tiles = List<Widget>.generate(
        itemCount - 1,
        (index) =>
            TileWidget(tile: Tile(Colors.grey, "Tile ${index.toString()}")));
    tiles.insert(indexEmpty, emptyTile);
  }

  @override
  Widget build(BuildContext context) {
    itemCount = nbColumns * nbColumns;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Invert two tiles with sizable grid"),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 500,
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: sqrt(itemCount).toInt()),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () => swapTiles(index),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        color: _isAdjacent(index, indexEmpty)
                            ? Colors.red
                            : Colors.white,
                        padding: const EdgeInsets.all(5),
                        child: tiles[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Slider(
            value: nbColumns.toDouble(),
            onChanged: (newNbColumns) => changeNbColumns(newNbColumns.toInt()),
            min: 2,
            divisions: 6,
            max: 8,
            label: nbColumns.toString(),
          )
        ],
      ),
    );
  }

  changeNbColumns(int newNbColumns) {
    setState(() {
      nbColumns = newNbColumns;
      itemCount = nbColumns * nbColumns;
      if (indexEmpty >= itemCount) indexEmpty = 0;
    });
    populateList();
  }

  swapTiles(int index) {
    if (_isAdjacent(index, indexEmpty)) {
      setState(() {
        tiles[indexEmpty] = tiles[index];
        tiles[index] = emptyTile;
        indexEmpty = index;
      });
    }
  }

  bool _isAdjacent(int index1, int index2) {
    int row1 = index1 ~/ nbColumns;
    int col1 = index1 % nbColumns;
    int row2 = index2 ~/ nbColumns;
    int col2 = index2 % nbColumns;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }
}
