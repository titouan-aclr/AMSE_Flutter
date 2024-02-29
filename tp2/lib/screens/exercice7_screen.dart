import 'dart:async';

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
  final Stopwatch _chronometer = Stopwatch();
  late Timer _timer = Timer(Duration.zero, () {});
  String _timerDisplay = '00:00';

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
    if (_isPlaying) {
      startTimer();
    } else {
      stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Jeu du Taquin"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Score : $scoreDisplay',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary)),
              Text('Timer : $_timerDisplay',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary))
            ],
          ),
          const SizedBox(height: 10),
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
              if (!_isPlaying) {
                setState(() {
                  levelChoosen = value!;
                });
                updateDifficulty(difficultyLevels.indexOf(value!));
              } else {
                showPlayingToast();
              }
            },
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
              onPressed: _isPlaying ? goBackToStart : null,
              icon: const Icon(Icons.autorenew_rounded),
              tooltip: "Reset All",
            ),
            IconButton(
              onPressed: _isPlaying ? showPlayingToast : removeColumn,
              icon: const Icon(Icons.remove),
              tooltip: "Remove Tiles",
            ),
            IconButton(
              onPressed: _isPlaying ? showPlayingToast : addColumn,
              icon: const Icon(Icons.add),
              tooltip: "Add Tiles",
            ),
            IconButton(
              onPressed: _isPlaying ? goBackAction : showNotPlayingToast,
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
    resetTimer();
  }

  void addColumn() {
    _puzzleGridKey.currentState?.addColumn();
    resetTimer();
  }

  void removeColumn() {
    _puzzleGridKey.currentState?.removeColumn();
    resetTimer();
  }

  void updateDifficulty(int level) {
    _puzzleGridKey.currentState!.updateDifficulty(level);
    resetTimer();
  }

  void displayScore(int score) {
    setState(() {
      scoreDisplay = score;
      
    });
  }

  void goBackAction() {
    _puzzleGridKey.currentState!.goBackAction();
  }

  void goBackToStart() {
    _puzzleGridKey.currentState!.goBackToStart();
    resetTimer();
    startTimer();
  }

  void displaySuccess() {
    stopTimer();
    showDialog(
      context: context,
      builder: (BuildContext context) => SuccessDialog(
          score: scoreDisplay,
          chrono: _timerDisplay,
          resetGameCallback: resetGame),
    );
  }

  void resetGame() {
    togglePlayStop();
    scoreDisplay = SCORE_INITIAL;
    _puzzleGridKey.currentState!.resetGame();
    resetTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        _timerDisplay =
            '${_chronometer.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_chronometer.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    _chronometer.start();
  }

  void stopTimer() {
    _timer.cancel();
    _chronometer.stop();
  }

  void resetTimer() {
    stopTimer();
    _chronometer.reset();
    setState(() {
      _timerDisplay = "00:00";
    });
  }

  void showPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Vous ne pouvez pas modifier les paramètres en jeu..."),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void showNotPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Jeu en pause..."),
      behavior: SnackBarBehavior.floating,
    ));
  }

}
