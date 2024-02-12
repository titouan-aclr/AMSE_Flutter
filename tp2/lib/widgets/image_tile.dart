import 'package:flutter/material.dart';

class Tile {
  String imageUrl;
  double factor;
  Alignment alignment;

  Tile({required this.imageUrl, required this.factor, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: alignment,
          widthFactor: factor,
          heightFactor: factor,
          child: Image.asset(imageUrl),
        ),
      ),
    );
  }
}
