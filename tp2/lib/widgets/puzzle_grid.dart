import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tp2/service/image_tiles_service.dart';
import 'package:tp2/widgets/image_tile.dart';

const int SCORE_INITIAL = 10000;
const int PENALITY = 200;

class PuzzleGrid extends StatefulWidget {
  final Function displayScoreCallback;
  final Function displaySuccessCallback;
  const PuzzleGrid(
      {super.key,
      required this.displayScoreCallback,
      required this.displaySuccessCallback});

  @override
  State<PuzzleGrid> createState() => PuzzleGridState();
}

class PuzzleGridState extends State<PuzzleGrid> {
  late List<ImageTile> tiles;
  late List<ImageTile> initialTiles;
  int indexEmpty = 1;
  int difficulty = 60;
  bool isPlaying = false;
  late ImageTileService imageTileService;
  late int score;
  late List<int> swapHistory = [];
  late bool isGoingBack = false;

  @override
  void initState() {
    imageTileService = ImageTileService();
    score = SCORE_INITIAL;
    updateDifficulty(0);
    swapHistory.add(indexEmpty);
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
              onTap: isPlaying ? () => swapTiles(index) : null,
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
    if (isPlaying == false) {
      score = SCORE_INITIAL;
      for (int i = 0; i < difficulty; i++) {
        int randomIndex2 = getRandomAdjacentIndex();
        swapTiles(randomIndex2);
      }
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
      if (isPlaying) {
        updateScore();
        if (!isGoingBack) {
          swapHistory.add(index);
        }
        if (checkSuccess()) widget.displaySuccessCallback();
      }
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
    updatePuzzle();
  }

  addColumn() {
    if (isPlaying == false) {
      if (imageTileService.getNbColumns() < 8) {
        imageTileService.setNbColumns(imageTileService.getNbColumns() + 1);
        updatePuzzle();
      }
    }
  }

  removeColumn() {
    if (isPlaying == false) {
      if (imageTileService.getNbColumns() > 2) {
        imageTileService.setNbColumns(imageTileService.getNbColumns() - 1);
        updatePuzzle();
      }
    }
  }

  updatePuzzle() {
    if (isPlaying == false) {
      setState(() {
        tiles = List.from(imageTileService.getTilesList());
        if (indexEmpty >= tiles.length) indexEmpty = 0;
        int idEmpty = tiles[indexEmpty].id;
        tiles[indexEmpty] = ImageTile(id: idEmpty, empty: true);
        resetInitialTiles();
        shuffleTilesDependingOnDifficulty(difficulty);
        swapHistory = [indexEmpty];
        score = SCORE_INITIAL;
      });
    }
  }

  void updateDifficulty(int level) {
    int nbColumns = imageTileService.getNbColumns();

    switch (level) {
      case 0:
        difficulty = nbColumns * 20;
        break;
      case 1:
        difficulty = nbColumns * 20;
        break;
      case 2:
        difficulty = nbColumns * 20;
        break;
      case 3:
        difficulty = nbColumns * 20;
        break;
      default:
        difficulty = nbColumns * 20;
    }

    updatePuzzle();
  }

  void updateScore() {
    if (isPlaying == true) {
      score = score - PENALITY;
      widget.displayScoreCallback(score);
    }
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void goBackAction() {
    isGoingBack = true;
    if (swapHistory.length > 1 && isPlaying) {
      swapTiles(swapHistory[swapHistory.length - 2]);
      swapHistory.removeLast();
      updateScore();
    }
    isGoingBack = false;
  }

  void resetInitialTiles() {
    initialTiles = List.from(tiles);
  }

  bool checkSuccess() {
    for (int i = 0; i < tiles.length; i++) {
      if (tiles[i].id != initialTiles[i].id) return false;
    }
    return true;
  }

  void resetGame() {
    indexEmpty = 1;
    score = SCORE_INITIAL;
    updateDifficulty(0);
  }
}
