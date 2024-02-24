import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_button.dart';

class ImageSelection extends StatefulWidget {
  final Function onImageChangeCallback;
  const ImageSelection({super.key, required this.onImageChangeCallback});

  @override
  State<ImageSelection> createState() => _ImageSelectionState();
}

class _ImageSelectionState extends State<ImageSelection> {
  List<String> imagesUrl = [
    'images/test.jpg',
    'images/test_tiers.png',
    'images/test_quarts.png'
  ];
  late List<ImageButton> list;
  int selectedImage = 0;

  @override
  void initState() {
    populateList();
    super.initState();
  }

  void populateList() {
    list = List<ImageButton>.generate(
      imagesUrl.length,
      (index) => ImageButton(
          id: index,
          imageUrl: imagesUrl[index],
          onPressedCallback: onImageButtonPressed,
          isSelected: index == selectedImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  void onImageButtonPressed(int idSelected) {
    setState(() {
      selectedImage = idSelected;
      populateList();
    });
    widget.onImageChangeCallback(imagesUrl[idSelected]);
  }
}
