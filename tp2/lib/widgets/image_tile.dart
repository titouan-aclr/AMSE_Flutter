import 'package:flutter/material.dart';

class ImageTile {
  String imageUrl;
  double factor;
  Alignment alignment;

  ImageTile(
      {required this.imageUrl, required this.factor, required this.alignment});

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
