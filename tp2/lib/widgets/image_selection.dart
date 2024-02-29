import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_button.dart';

class ImageSelection extends StatefulWidget {
  final Function onImageChangeCallback;
  const ImageSelection({super.key, required this.onImageChangeCallback});

  @override
  State<ImageSelection> createState() => ImageSelectionState();
}

class ImageSelectionState extends State<ImageSelection> {
  List<String> imagesUrl = [
    'images/test.jpg',
    'images/montagne.jpg',
    'images/dolphin-happy.gif'
  ];
  late List<ImageButton> list;
  int selectedImage = 0;
  bool isPlaying = false; 

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
    if(!isPlaying) {
      setState(() {
        selectedImage = idSelected;
        populateList();
      });
      widget.onImageChangeCallback(imagesUrl[idSelected]);
    }
  }

  void togglePlayStop() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }
}
