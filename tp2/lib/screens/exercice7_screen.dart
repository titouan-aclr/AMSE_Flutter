import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_selection.dart';
import 'package:tp2/widgets/puzzle_grid.dart';

final GlobalKey<PuzzleGridState> _puzzleGridKey = GlobalKey<PuzzleGridState>();

class Exercice7Screen extends StatefulWidget {
  const Exercice7Screen({super.key});

  @override
  State<Exercice7Screen> createState() => _Exercice7ScreenState();
}

class _Exercice7ScreenState extends State<Exercice7Screen> {
  bool isPlaying = false;
  late PuzzleGrid _puzzleGrid;

  @override
  void initState() {
    super.initState();
    _puzzleGrid = PuzzleGrid(key: _puzzleGridKey);
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
    });
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
          ImageSelection(onImageChangeCallback: onImageChange),
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
}
