import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tp2/service/image_tiles_service.dart';
import 'package:tp2/widgets/image_tile.dart';

/// CONSTANTES
const int SCORE_INITIAL = 10000;
const int PENALITY = 3;

/*****************/
/* WIDGET CLASS  */
/*****************/
class PuzzleGrid extends StatefulWidget {
  final Function displayScoreCallback; //-> fonction d'affichage du score actuel
  final Function displaySuccessCallback; //-> fonction affichage gagner
  const PuzzleGrid(
      {super.key,
      required this.displayScoreCallback,
      required this.displaySuccessCallback});

  @override
  State<PuzzleGrid> createState() => PuzzleGridState();
}

/*****************/
/*  STATE CLASS  */
/*****************/
class PuzzleGridState extends State<PuzzleGrid> {
  late List<ImageTile> _tiles; //-> liste des fragments d'images
  late List<ImageTile> _initialTiles; //-> listes des fragments sans mélange
  int _indexEmpty = 1; //-> index de la case vide
  int _difficulty = 60; //-> nombre de déplacements lors du mélange
  bool _isPlaying = false; //-> jeu en cours ou non
  late ImageTileService
      _imageTileService; //-> service de divison de l'image en tuiles
  late int _score; //-> score actuel calculé
  late List<int> _swapHistory = []; //-> historique des déplacements
  late bool _isGoingBack = false; //-> en cours d'annulation du coup joué ou non

  /// INITIALISATION
  @override
  void initState() {
    _imageTileService = ImageTileService();
    _score = SCORE_INITIAL;
    updateDifficulty(0); // difficulté standard par défaut
    _swapHistory.add(_indexEmpty);
    super.initState();
  }

  /// CONSTRUCTION DE L'UI
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            height: MediaQuery.of(context).size.width - 20, //selon écran
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: _tiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _imageTileService.getNbColumns()),
              itemBuilder: (BuildContext context, int index) {
                // affichages des tuiles
                return InkWell(
                  onTap: _isPlaying
                      ? () => _swapTiles(index)
                      : _showNotPlayingToast,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: _isAdjacent(index, _indexEmpty)
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7)
                            : Colors.transparent,
                        padding: const EdgeInsets.all(4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          // affichage de ImageTile
                          child: _tiles[index].croppedImageTile(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// FONCTIONS POUR GESTION DE LA DIFFICULTE
  // mélanger les tuiles selon le niveau de difficulté sélectionné
  _shuffleTilesDependingOnDifficulty(int difficulty) {
    if (_isPlaying == false) {
      _score = SCORE_INITIAL;
      for (int i = 0; i < difficulty; i++) {
        int randomIndex2 = _getRandomAdjacentIndex();
        _swapTiles(randomIndex2);
      }
    }
  }

  // obtenir une tuile au hasard parmi celles adjacentes pour la case vide
  int _getRandomAdjacentIndex() {
    int nbColumns = _imageTileService.getNbColumns();
    List<int> coordonnatesEmptyTile = _recupRowColumnOfEmptyTile();
    List<int> adjacentIndices = [];

    // Haut
    if (coordonnatesEmptyTile[0] > 0) {
      adjacentIndices.add(_indexEmpty - nbColumns);
    }

    // Bas
    if (coordonnatesEmptyTile[0] < nbColumns - 1) {
      adjacentIndices.add(_indexEmpty + nbColumns);
    }

    // Gauche
    if (coordonnatesEmptyTile[1] > 0) {
      adjacentIndices.add(_indexEmpty - 1);
    }
    // Droite
    if (coordonnatesEmptyTile[1] < nbColumns - 1) {
      adjacentIndices.add(_indexEmpty + 1);
    }

    var randomValue = Random().nextInt(adjacentIndices.length);

    return adjacentIndices[randomValue];
  }

  // obtention des coordonnées de la case vide (ligne, colonne)
  List<int> _recupRowColumnOfEmptyTile() {
    int nbColumns = _imageTileService.getNbColumns();
    int comparator = 0;
    int effectiveRow = 0;
    int effectiveColumn = 0;
    int i = 0;

    for (i; i < _tiles.length; i++) {
      if (i == _indexEmpty) {
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

  /// FONCTION POUR ECHANGE DE TUILES
  // échange effectif des tuiles
  _swapTiles(int index) {
    if (_isAdjacent(index, _indexEmpty)) {
      setState(() {
        ImageTile tempo = _tiles[_indexEmpty];
        _tiles[_indexEmpty] = _tiles[index];
        _tiles[index] = tempo;
        _indexEmpty = index;
      });
      if (_isPlaying) {
        _updateScore();
        if (!_isGoingBack) {
          _swapHistory.add(index);
        }
        if (_checkSuccess()) widget.displaySuccessCallback();
      }
    }
  }

  // vérification que la tuile à échangerest adjacente à la case vide
  bool _isAdjacent(int index1, int index2) {
    int nbColumns = _imageTileService.getNbColumns();
    int row1 = index1 ~/ nbColumns;
    int col1 = index1 % nbColumns;
    int row2 = index2 ~/ nbColumns;
    int col2 = index2 % nbColumns;

    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  /// FONCTION POUR LA GESTION DU CHANGEMENT D'IMAGE
  onImageChange(String newImageUrl) {
    _imageTileService.setImageUrl(newImageUrl);
    _updatePuzzle();
  }

  /// FONCTIONS POUR GESTION DIMENSIONS PUZZLE
  addColumn() {
    if (_isPlaying == false) {
      if (_imageTileService.getNbColumns() < 8) {
        _imageTileService.setNbColumns(_imageTileService.getNbColumns() + 1);
        _updatePuzzle();
      }
    }
  }

  removeColumn() {
    if (_isPlaying == false) {
      if (_imageTileService.getNbColumns() > 2) {
        _imageTileService.setNbColumns(_imageTileService.getNbColumns() - 1);
        _updatePuzzle();
      }
    }
  }

  /// FONCTION POUR LA MISE A JOUR DE LA GRILLE SELON NOUVEAUX PARAMETRES
  _updatePuzzle() {
    if (_isPlaying == false) {
      setState(() {
        _tiles = List.from(_imageTileService.getTilesList());
        if (_indexEmpty >= _tiles.length) _indexEmpty = 0;
        int idEmpty = _tiles[_indexEmpty].id;
        _tiles[_indexEmpty] = ImageTile(id: idEmpty, empty: true);
        _resetInitialTiles();
        _shuffleTilesDependingOnDifficulty(_difficulty);
        _swapHistory = [_indexEmpty];
        _score = SCORE_INITIAL;
      });
    }
    _score = SCORE_INITIAL;
  }

  /// FONCTION POUR GESTION DIFFICULTE
  void updateDifficulty(int level) {
    int nbColumns = _imageTileService.getNbColumns();

    switch (level) {
      case 0:
        _difficulty = nbColumns * 20;
        break;
      case 1:
        _difficulty = nbColumns * 20;
        break;
      case 2:
        _difficulty = nbColumns * 20;
        break;
      case 3:
        _difficulty = nbColumns * 20;
        break;
      default:
        _difficulty = nbColumns * 20;
    }

    _updatePuzzle();
  }

  /// FONCTION MISE A JOUR DU SCORE
  void _updateScore() {
    if (_isPlaying == true) {
      _score = _score - PENALITY;
      widget.displayScoreCallback(_score);
    }
  }

  /// FONCTIONS DE GESTION PLAY / PAUSE
  // fontion lors d'un appui sur le bouton
  void togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // fonction lors d'une tentative de jouer en pause
  void _showNotPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Jeu en pause..."),
      behavior: SnackBarBehavior.floating,
    ));
  }

  /// FONCTION POUR ANNULATION DES COUPS
  // annulation d'un seul coup
  void goBackAction() {
    _isGoingBack = true;
    if (_swapHistory.length > 1 && _isPlaying) {
      _swapTiles(_swapHistory[_swapHistory.length - 2]);
      _swapHistory.removeLast();
      _updateScore();
    }
    _isGoingBack = false;
  }

  // annulation de tous les coups
  void goBackToStart() {
    if (_isPlaying) {
      while (_swapHistory.length > 1) {
        goBackAction();
      }
      _score = SCORE_INITIAL;
      widget.displayScoreCallback(_score);
    }
  }

  // réinitialiser la liste des tuiles d'origine
  void _resetInitialTiles() {
    _initialTiles = List.from(_tiles);
  }

  // réinitisaliser l'ensemble du jeu
  void resetGame() {
    _indexEmpty = 1;
    _isPlaying = false;
    _score = SCORE_INITIAL;
    updateDifficulty(0);
  }

  /// FONCTION VERIFICATION VICTOIRE
  bool _checkSuccess() {
    for (int i = 0; i < _tiles.length; i++) {
      if (_tiles[i].id != _initialTiles[i].id) return false;
    }
    return true;
  }
}
