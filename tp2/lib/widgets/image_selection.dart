import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_button.dart';

/*****************/
/* WIDGET CLASS  */
/*****************/
class ImageSelection extends StatefulWidget {
  final Function
      onImageChangeCallback; //-> fonction pour notification de changement d'image
  const ImageSelection({super.key, required this.onImageChangeCallback});

  @override
  State<ImageSelection> createState() => ImageSelectionState();
}

/*****************/
/*  STATE CLASS  */
/*****************/
class ImageSelectionState extends State<ImageSelection> {
  List<String> imagesUrl = [
    'images/test.jpg',
    'images/montagne.jpg',
    'images/dolphin-happy.gif'
  ]; //-> liste des images proposées stockées dans les assets
  late List<ImageButton> list; //-> liste des boutons à affichager
  int selectedImage = 0; //-> image actuellement sélectionnées
  bool _isPlaying = false; // -> jeu en cours ou non

  /// INITIALISATION
  @override
  void initState() {
    populateList();
    super.initState();
  }

  // génerer une liste de boutons selon les images proposées
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

  /// CONSTRUCTION DE L'UI
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: list,
    );
  }

  /// GESTION DE LA SELECTION D'UNE IMAGE
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

  /// FONCTION DE GESTION PLAY / PAUSE
  // changement de l'état du widget
  void togglePlayStop() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // fonction lors d'une tentative de modification de l'image en jeu
  void showPlayingToast() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Vous ne pouvez pas modifier les paramètres en jeu..."),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
