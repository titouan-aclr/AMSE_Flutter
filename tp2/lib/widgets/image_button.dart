import 'package:flutter/material.dart';

/*****************/
/* WIDGET CLASS  */
/*****************/
class ImageButton extends StatelessWidget {
  final int id; //-> identifiant de l'image (= position dans la liste)
  final String imageUrl; //-> chemin vers l'image dans les assets
  final Function onPressedCallback; //-> fonction de getion de sélection
  final bool isSelected; //-> image actuellement sélectionnée ou non
  const ImageButton(
      {super.key,
      required this.id,
      required this.imageUrl,
      required this.onPressedCallback,
      required this.isSelected});

  /// CONSTRUCTION DE L'UI
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
            : Colors.transparent,
        height: 100,
        child: InkWell(
          onTap: () => onPressedCallback(id),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
