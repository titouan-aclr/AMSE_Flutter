import 'package:flutter/material.dart';

class ImageTile {
  int id;
  String? imageUrl;
  double? factor;
  Alignment? alignment;
  bool empty;

  ImageTile({
    required this.id,
    this.imageUrl,
    this.factor,
    this.alignment,
    required this.empty,
  });

  Widget croppedImageTile() {
    if (!empty) {
      return FittedBox(
        fit: BoxFit.fill,
        child: ClipRect(
          child: Align(
            alignment: alignment!,
            widthFactor: factor,
            heightFactor: factor,
            child: Image.asset(imageUrl!),
          ),
        ),
      );
    } else {
      return FittedBox(
        fit: BoxFit.fill,
        child: Container(color: Colors.white),
      );
    }
  }
}
