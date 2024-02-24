import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

class ImageTileService {
  List<ImageTile> tilesList = [];
  int nbColumns = 3;
  String imageUrl = 'images/test.jpg';

  /// CONSTRUCTOR
  ImageTileService() {
    _splitImageIntoTiles();
  }

  /// GETTERS AND SETTERS
  List<ImageTile> getTilesList() {
    return tilesList;
  }

  void setTilesList(List<ImageTile> list) {
    tilesList = list;
  }

  int getNbColumns() {
    return nbColumns;
  }

  void setNbColumns(int nbOfColumns) {
    nbColumns = nbOfColumns;
    _splitImageIntoTiles();
  }

  String getImageUrl() {
    return imageUrl;
  }

  void setImageUrl(String newImageUrl) {
    imageUrl = newImageUrl;
    _splitImageIntoTiles();
  }

  /// GAME RULES
  List<double> _computeIndexes() {
    List<double> result = [];
    double temp = 0;

    for (int i = 0; i < nbColumns; i++) {
      temp = ((2 * i) / (nbColumns - 1)) - 1;
      result.add(temp);
    }
    return result;
  }

  void _splitImageIntoTiles() {
    List<double> indexes = _computeIndexes();
    tilesList = [];

    for (var y in indexes) {
      for (var x in indexes) {
        tilesList.add(
          ImageTile(
            factor: 1 / nbColumns,
            alignment: Alignment(x, y),
            imageUrl: imageUrl,
          ),
        );
      }
    }
  }
}
