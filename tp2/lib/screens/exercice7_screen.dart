import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_selection.dart';
import 'package:tp2/widgets/puzzle_grid.dart';
import 'package:tp2/widgets/success_dialog.dart';

final GlobalKey<PuzzleGridState> _puzzleGridKey = GlobalKey<PuzzleGridState>();
final GlobalKey<ImageSelectionState> _imageSelectionKey =
    GlobalKey<ImageSelectionState>();

const List<String> difficultyLevels = [
  "Débutant",
  "Confirmé",
  "Expert",
  "Légende"
];

class Exercice7Screen extends StatefulWidget {
  const Exercice7Screen({super.key});

  @override
  State<Exercice7Screen> createState() => _Exercice7ScreenState();
}

class _Exercice7ScreenState extends State<Exercice7Screen> {
  bool _isPlaying = false;
  late PuzzleGrid _puzzleGrid;
  late ImageSelection _imageSelection;
  String levelChoosen = difficultyLevels[0];
  int scoreDisplay = SCORE_INITIAL;

  @override
  void initState() {
    super.initState();
    _puzzleGrid = PuzzleGrid(
        key: _puzzleGridKey,
        displayScoreCallback: displayScore,
        displaySuccessCallback: displaySuccess);
    _imageSelection = ImageSelection(
        key: _imageSelectionKey, onImageChangeCallback: onImageChange);
  }

  void togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    _puzzleGridKey.currentState!.togglePlayStop();
    _imageSelectionKey.currentState!.togglePlayStop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Invert two tiles with sizable grid"),
      ),
      body: Column(
        children: [
          _puzzleGrid,
          _imageSelection,
          DropdownButton(
            value: levelChoosen,
            items: difficultyLevels.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (_isPlaying == false) {
                setState(() {
                  levelChoosen = value!;
                });
                updateDifficulty(difficultyLevels.indexOf(value!));
              }
            },
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              'SCORE : $scoreDisplay',
              style: const TextStyle(fontSize: 40.0),
            ),
          ),
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
        tooltip: _isPlaying ? "Play" : "Stop",
        child: _isPlaying
            ? const Icon(Icons.stop_circle_rounded)
            : const Icon(Icons.play_arrow_rounded),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: goBackToStart,
              icon: const Icon(Icons.autorenew_rounded),
              tooltip: "Reset All",
            ),
            IconButton(
              onPressed: removeColumn,
              icon: const Icon(Icons.remove),
              tooltip: "Remove Tiles",
            ),
            IconButton(
              onPressed: addColumn,
              icon: const Icon(Icons.add),
              tooltip: "Add Tiles",
            ),
            IconButton(
              onPressed: goBackAction,
              icon: const Icon(Icons.undo_rounded),
              tooltip: "Go Back",
            ),
          ],
        ),
      ),
    );
  }

  void onImageChange(String newImageUrl) {
    _puzzleGridKey.currentState?.onImageChange(newImageUrl);
  }

  void addColumn() {
    _puzzleGridKey.currentState?.addColumn();
  }

  void removeColumn() {
    _puzzleGridKey.currentState?.removeColumn();
  }

  void updateDifficulty(int level) {
    _puzzleGridKey.currentState!.updateDifficulty(level);
  }

  void displayScore(int score) {
    setState(() {
      scoreDisplay = score;
    });
  }

  void goBackAction() {
    _puzzleGridKey.currentState!.goBackAction();
  }

  void goBackToStart(){
    _puzzleGridKey.currentState!.goBackToStart();
  }

  void displaySuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          SuccessDialog(score: scoreDisplay, resetGameCallback: resetGame),
    );
  }

  void resetGame() {
    togglePlayStop();
    scoreDisplay = SCORE_INITIAL;
    _puzzleGridKey.currentState!.resetGame();
  }
}
