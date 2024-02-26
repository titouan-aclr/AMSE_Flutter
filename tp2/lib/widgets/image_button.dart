import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final int id;
  final String imageUrl;
  final Function onPressedCallback;
  final bool isSelected;
  const ImageButton(
      {super.key,
      required this.id,
      required this.imageUrl,
      required this.onPressedCallback,
      required this.isSelected});

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
