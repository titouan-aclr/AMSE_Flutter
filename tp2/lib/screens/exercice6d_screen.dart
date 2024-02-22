import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp2/service/image_tiles_service.dart';
import 'package:tp2/widgets/image_tile.dart';

class Exercice6dScreen extends StatefulWidget {
  const Exercice6dScreen({super.key});

  @override
  State<Exercice6dScreen> createState() => _Exercice6cScreenState();
}

class _Exercice6cScreenState extends State<Exercice6dScreen> {
  int nbColumns = 3;
  late int itemCount = 9;
  int indexEmpty = 1;
  late List<ImageTile> tiles;
  //ImageTile emptyTile = ImageTile(tile: Tile(Colors.white, "Empty"));
  late ImageTileService imageTileService;

  @override
  void initState() {
    imageTileService = ImageTileService('images/test.jpg', nbColumns);
    tiles = imageTileService.getTilesList();
    super.initState();
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
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        color: _isAdjacent(index, indexEmpty)
                            ? Colors.red
                            : Colors.white,
                        padding: const EdgeInsets.all(2),
                        child: tiles[index].croppedImageTile(),
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
      imageTileService.setNbColumns(nbColumns);
      tiles = imageTileService.getTilesList();
    });
  }

  swapTiles(int index) {
    if (_isAdjacent(index, indexEmpty)) {
      setState(() {
        ImageTile tempo = tiles[indexEmpty];
        tiles[indexEmpty] = tiles[index];
        tiles[index] = tempo;
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
