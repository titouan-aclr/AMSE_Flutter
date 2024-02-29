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
  bool _isPlaying = false;

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
    if (!_isPlaying) {
      setState(() {
        selectedImage = idSelected;
        populateList();
      });
      widget.onImageChangeCallback(imagesUrl[idSelected]);
    } else {
      showPlayingToast();
    }
  }

  void togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void showPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Vous ne pouvez pas modifier les paramètres en jeu..."),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
