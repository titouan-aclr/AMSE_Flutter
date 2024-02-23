import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp2/service/image_tiles_service.dart';
import 'package:tp2/widgets/image_tile.dart';

class Exercice7Screen extends StatefulWidget {
  const Exercice7Screen({super.key});

  @override
  State<Exercice7Screen> createState() => _Exercice7ScreenState();
}

class _Exercice7ScreenState extends State<Exercice7Screen> {
  int nbColumns = 3;
  int indexEmpty = 1;
  late List<ImageTile> tiles;
  late ImageTileService imageTileService;

  bool isPlaying = false;
  int difficulty = 30;
  List<int> difficultyLevels = [5, 10, 15, 20];

  get onPressed => null;

  @override
  void initState() {
    imageTileService = ImageTileService('images/test.jpg', nbColumns);
    tiles = imageTileService.getTilesList();
    shuffleTilesDependingOnDifficulty(difficulty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void togglePlayStop() {
      setState(() {
        isPlaying = !isPlaying;
      });
    }

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
                  itemCount: tiles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: nbColumns),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => swapTiles(index),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
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
              onChanged: (newNbColumns) =>
                  changeNbColumns(newNbColumns.toInt()),
              min: 2,
              divisions: 6,
              max: 8,
              label: nbColumns.toString(),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            togglePlayStop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45.0),
          ),
          tooltip: isPlaying ? "Play" : "Stop",
          child: isPlaying
              ? const Icon(Icons.play_arrow_rounded)
              : const Icon(Icons.stop_circle_rounded),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              onPressed: () {
                changeNbColumns((nbColumns <= 2) ? nbColumns : nbColumns - 1);
              },
              icon: const Icon(Icons.remove),
              tooltip: "Remove Tiles",
            ),
            IconButton(
              onPressed: () {
                changeNbColumns((nbColumns >= 8) ? nbColumns : nbColumns + 1);
              },
              icon: const Icon(Icons.add),
              tooltip: "Add Tiles",
            ),
            DropdownButton(
                items: difficultyLevels.map((item) {
                  return DropdownMenuItem(
                      value: item, child: Text(item.toString()));
                }).toList(),
                onChanged: (selectedValue) {
                  setState(() {
                    difficulty = int.parse(selectedValue as String);
                    shuffleTilesDependingOnDifficulty(difficulty);
                  });
                })
          ]),
        ));
  }

  changeNbColumns(int newNbColumns) {
    setState(() {
      nbColumns = newNbColumns;
      if (indexEmpty >= tiles.length) indexEmpty = 0;
      imageTileService.setNbColumns(nbColumns);
      tiles = imageTileService.getTilesList();
      shuffleTilesDependingOnDifficulty(difficulty);
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

  void shuffleTilesDependingOnDifficulty(int difficulty) {
    for (int i = 0; i < difficulty; i++) {
      int randomIndex2 = getRandomAdjacentIndex();
      swapTiles(randomIndex2);
    }
  }

  int getRandomAdjacentIndex() {
    List<int> coordonnatesEmptyTile = recupRowColumnOfEmptyTile();
    List<int> adjacentIndices = [];

    // Haut
    if (coordonnatesEmptyTile[0] > 0) {
      adjacentIndices.add(indexEmpty - nbColumns);
    }

    // Bas
    if (coordonnatesEmptyTile[0] < nbColumns - 1) {
      adjacentIndices.add(indexEmpty + nbColumns);
    }

    // Gauche
    if (coordonnatesEmptyTile[1] > 0) {
      adjacentIndices.add(indexEmpty - 1);
    }
    // Droite
    if (coordonnatesEmptyTile[1] < nbColumns - 1) {
      adjacentIndices.add(indexEmpty + 1);
    }

    var randomValue = Random().nextInt(adjacentIndices.length);

    return adjacentIndices[randomValue];
  }

  List<int> recupRowColumnOfEmptyTile() {
    int comparator = 0;
    int effectiveRow = 0;
    int effectiveColumn = 0;
    int i = 0;

    for (i; i < tiles.length; i++) {
      if (i == indexEmpty) {
        for (int j = 0; j < nbColumns; j++) {
          comparator += nbColumns;
          if (i < comparator) {
            effectiveColumn = i - nbColumns * effectiveRow;
          } else {
            effectiveRow += 1;
          }
        }
      }
    }
    return [effectiveRow, effectiveColumn];
  }
}
