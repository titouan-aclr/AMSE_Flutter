import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp2/service/image_tiles_service.dart';
import 'package:tp2/widgets/image_tile.dart';

class PuzzleGrid extends StatefulWidget {
  const PuzzleGrid({super.key});

  @override
  State<PuzzleGrid> createState() => PuzzleGridState();
}

class PuzzleGridState extends State<PuzzleGrid> {
  late List<ImageTile> tiles;
  int indexEmpty = 1;
  int difficulty = 30;
  List difficultyLevels = ["Débutant", "Confirmé", "Expert", "Légende"];
  late ImageTileService imageTileService;

  @override
  void initState() {
    imageTileService = ImageTileService();
    tiles = imageTileService.getTilesList();
    difficultyManagement(0);
    shuffleTilesDependingOnDifficulty(difficulty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: tiles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: imageTileService.getNbColumns()),
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
    );
  }

  /// FUNCTIONS FOR SHUFFLE
  shuffleTilesDependingOnDifficulty(int difficulty) {
    tiles = imageTileService.getTilesList();
    for (int i = 0; i < difficulty; i++) {
      int randomIndex2 = getRandomAdjacentIndex();
      swapTiles(randomIndex2);
    }
  }

  int getRandomAdjacentIndex() {
    int nbColumns = imageTileService.getNbColumns();
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
    int nbColumns = imageTileService.getNbColumns();
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

  /// FUNCTION FOR SWAPING TILES
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
    int nbColumns = imageTileService.getNbColumns();
    int row1 = index1 ~/ nbColumns;
    int col1 = index1 % nbColumns;
    int row2 = index2 ~/ nbColumns;
    int col2 = index2 % nbColumns;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  /// FUNCTIONS FOR GAME FUNCTIONALITY
  onImageChange(String newImageUrl) {
    imageTileService.setImageUrl(newImageUrl);
    setState(() {
      tiles = imageTileService.getTilesList();
      shuffleTilesDependingOnDifficulty(difficulty);
    });
  }

  addColumn() {
    if (imageTileService.getNbColumns() < 8) {
      imageTileService.setNbColumns(imageTileService.getNbColumns() + 1);
      updatePuzzle();
    }
  }

  removeColumn() {
    if (imageTileService.getNbColumns() > 2) {
      imageTileService.setNbColumns(imageTileService.getNbColumns() - 1);
      updatePuzzle();
    }
  }

  updatePuzzle() {
    setState(() {
      tiles = imageTileService.getTilesList();
      if (indexEmpty >= tiles.length) indexEmpty = 0;
      shuffleTilesDependingOnDifficulty(difficulty);
    });
  }

  int difficultyManagement(int level){
    int nbColumns = imageTileService.getNbColumns();
    if(level == 0){
      difficulty  =  nbColumns * 20;
    }
    if(level == 1){
      difficulty  =  nbColumns * 60;
    }
    if(level == 2){
      difficulty  =  nbColumns * 100;
    }
    if(level == 3){
      difficulty  =  nbColumns * 500;
    }
    return difficulty;
  }

}
