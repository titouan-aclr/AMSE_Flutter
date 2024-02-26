import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_selection.dart';
import 'package:tp2/widgets/puzzle_grid.dart';

final GlobalKey<PuzzleGridState> _puzzleGridKey = GlobalKey<PuzzleGridState>();
final GlobalKey<ImageSelectionState> _imageSelectionKey = GlobalKey<ImageSelectionState>();

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
  bool isPlaying = false;
  late PuzzleGrid _puzzleGrid;
  late ImageSelection _imageSelection;
  String levelChoosen = difficultyLevels[0];
  int scoreDisplay = 0;

  @override
  void initState() {
    super.initState();
    _puzzleGrid =
        PuzzleGrid(key: _puzzleGridKey, displayScoreCallback: displayScore);
    _imageSelection = ImageSelection(key:_imageSelectionKey, onImageChangeCallback: onImageChange);
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
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
              if(isPlaying == false){
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
        tooltip: isPlaying ? "Play" : "Stop",
        child: isPlaying
            ? const Icon(Icons.stop_circle_rounded)
            : const Icon(Icons.play_arrow_rounded),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
}
