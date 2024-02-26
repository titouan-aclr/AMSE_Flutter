import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

class ImageTileService {
  List<ImageTile> _tilesList = [];
  int _nbColumns = 3;
  String _imageUrl = 'images/test.jpg';

  /// CONSTRUCTOR
  ImageTileService() {
    _splitImageIntoTiles();
  }

  /// GETTERS AND SETTERS
  List<ImageTile> getTilesList() {
    return _tilesList;
  }

  void setTilesList(List<ImageTile> list) {
    _tilesList = list;
  }

  int getNbColumns() {
    return _nbColumns;
  }

  void setNbColumns(int nbOfColumns) {
    _nbColumns = nbOfColumns;
    _splitImageIntoTiles();
  }

  String getImageUrl() {
    return _imageUrl;
  }

  void setImageUrl(String newImageUrl) {
    _imageUrl = newImageUrl;
    _splitImageIntoTiles();
  }

  /// GAME RULES
  List<double> _computeIndexes() {
    List<double> result = [];
    double temp = 0;

    for (int i = 0; i < _nbColumns; i++) {
      temp = ((2 * i) / (_nbColumns - 1)) - 1;
      result.add(temp);
    }
    return result;
  }

  void _splitImageIntoTiles() {
    List<double> indexes = _computeIndexes();
    _tilesList = [];

    for (var y in indexes) {
      for (var x in indexes) {
        _tilesList.add(
          ImageTile(
            factor: 1 / _nbColumns,
            alignment: Alignment(x, y),
            imageUrl: _imageUrl,
          ),
        );
      }
    }
  }
}
