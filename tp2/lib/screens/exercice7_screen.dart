import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_selection.dart';
import 'package:tp2/widgets/puzzle_grid.dart';
import 'package:tp2/widgets/success_dialog.dart';

/// CONSTANTES
final GlobalKey<PuzzleGridState> _puzzleGridKey = GlobalKey<PuzzleGridState>();
final GlobalKey<ImageSelectionState> _imageSelectionKey =
    GlobalKey<ImageSelectionState>();
const List<String> difficultyLevels = [
  "Débutant",
  "Confirmé",
  "Expert",
  "Légende"
];

/*****************/
/* WIDGET CLASS  */
/*****************/
class Exercice7Screen extends StatefulWidget {
  const Exercice7Screen({super.key});

  @override
  State<Exercice7Screen> createState() => _Exercice7ScreenState();
}

/*****************/
/*  STATE CLASS  */
/*****************/
class _Exercice7ScreenState extends State<Exercice7Screen> {
  bool _isPlaying = false; // -> jeu en cours ou non
  late PuzzleGrid _puzzleGrid; // -> widget grille puzzle
  late ImageSelection _imageSelection; // -> widget selection image
  String _levelChoosen = difficultyLevels[0]; // -> niveau de difficulté
  int _scoreDisplay = SCORE_INITIAL; // -> score affiché
  final Stopwatch _chronometer = Stopwatch(); // -> chronomètre
  late Timer _timer = Timer(Duration.zero, () {}); // -> timer pour chronomètre
  String _timerDisplay = '00:00'; // -> affichage du chronomètre

  /// INITIALISATION DES WIDGETS
  @override
  void initState() {
    super.initState();
    _puzzleGrid = PuzzleGrid(
      key: _puzzleGridKey,
      displayScoreCallback: _displayScore,
      displaySuccessCallback: _displaySuccess,
    );
    _imageSelection = ImageSelection(
      key: _imageSelectionKey,
      onImageChangeCallback: _onImageChange,
    );
  }

  /// CONSTRUCTION DE L'UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Jeu du Taquin"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Affichage des scores (points + chronomètre)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Score : $_scoreDisplay',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary)),
              Text('Temps : $_timerDisplay',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary))
            ],
          ),
          const SizedBox(height: 10),
          // Grille du puzzle
          _puzzleGrid,
          // Selection de l'image
          _imageSelection,
          // Selection de la difficulté
          DropdownButton(
            value: _levelChoosen,
            items: difficultyLevels.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              if (!_isPlaying) {
                setState(() {
                  _levelChoosen = value!;
                });
                _updateDifficulty(difficultyLevels.indexOf(value!));
              } else {
                _showPlayingToast();
              }
            },
          ),
        ],
      ),
      // Bouton play / pause
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => _togglePlayStop(),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
        tooltip: _isPlaying ? "Play" : "Stop",
        child: _isPlaying
            ? const Icon(Icons.stop_circle_rounded)
            : const Icon(Icons.play_arrow_rounded),
      ),
      // Barre de controle
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // bouton de reset de la partie
            IconButton(
              onPressed: _isPlaying ? _goBackToStart : null,
              icon: const Icon(Icons.autorenew_rounded),
              tooltip: "Reset All",
            ),
            // bouton de diminution de colonnes
            IconButton(
              onPressed: _isPlaying ? _showPlayingToast : _removeColumn,
              icon: const Icon(Icons.remove),
              tooltip: "Remove Tiles",
            ),
            // bouton d'augmentation des colonnes
            IconButton(
              onPressed: _isPlaying ? _showPlayingToast : _addColumn,
              icon: const Icon(Icons.add),
              tooltip: "Add Tiles",
            ),
            // bouton d'annulation du coup
            IconButton(
              onPressed: _isPlaying ? _goBackAction : _showNotPlayingToast,
              icon: const Icon(Icons.undo_rounded),
              tooltip: "Go Back",
            ),
          ],
        ),
      ),
    );
  }

  /// FONCTIONS DE GESTION PLAY / PAUSE
  // fontion lors d'un appui sur le bouton
  void _togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    _puzzleGridKey.currentState!.togglePlayStop();
    _imageSelectionKey.currentState!.togglePlayStop();
    if (_isPlaying) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  // fonction lors d'une tentative de modification de paramètres en jeu
  void _showPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Vous ne pouvez pas modifier les paramètres en jeu..."),
      behavior: SnackBarBehavior.floating,
    ));
  }

  // fonction lors d'une tentative de jouer en pause
  void _showNotPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Jeu en pause..."),
      behavior: SnackBarBehavior.floating,
    ));
  }

  /// FONCTION POUR CHANGEMENT D'IMAGE
  void _onImageChange(String newImageUrl) {
    _puzzleGridKey.currentState?.onImageChange(newImageUrl);
    _resetTimer();
  }

  /// FONCTIONS POUR GESTION DIMENSIONS PUZZLE
  void _addColumn() {
    _puzzleGridKey.currentState?.addColumn();
    _resetTimer();
  }

  void _removeColumn() {
    _puzzleGridKey.currentState?.removeColumn();
    _resetTimer();
  }

  /// FONCTION POUR GESTION DIFFICULTE
  void _updateDifficulty(int level) {
    _puzzleGridKey.currentState!.updateDifficulty(level);
    _resetTimer();
  }

  /// FONCTIONS POUR AFFICHAGES DE ELEMENTS
  // affichage du score
  void _displayScore(int score) {
    setState(() {
      _scoreDisplay = score;
    });
  }

  // affichage d'une pop-up lorsque le joueur gagne
  void _displaySuccess() {
    _stopTimer();
    showDialog(
      context: context,
      builder: (BuildContext context) => SuccessDialog(
          score: _scoreDisplay,
          chrono: _timerDisplay,
          resetGameCallback: _resetGame),
    );
  }

  /// FONCTIONS POUR ANNULATION DES COUPS
  // annulation d'un seul coup
  void _goBackAction() {
    _puzzleGridKey.currentState!.goBackAction();
  }

  // annulation de tous les coups
  void _goBackToStart() {
    _puzzleGridKey.currentState!.goBackToStart();
    _resetTimer();
    _startTimer();
  }

  // remise à zéro du jeu complet
  void _resetGame() {
    _togglePlayStop();
    _scoreDisplay = SCORE_INITIAL;
    _puzzleGridKey.currentState!.resetGame();
    _resetTimer();
  }

  /// FONCTIONS POUR GESTION DU CHRONOMETRE
  // démarrer le chronomètre
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        _timerDisplay =
            '${_chronometer.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_chronometer.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
    _chronometer.start();
  }

  // arrêter le chronomètre
  void _stopTimer() {
    _timer.cancel();
    _chronometer.stop();
  }

  // réinitialiser le chronomètre
  void _resetTimer() {
    _stopTimer();
    _chronometer.reset();
    setState(() {
      _timerDisplay = "00:00";
    });
  }
}
