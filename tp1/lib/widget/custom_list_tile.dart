import 'package:flutter/material.dart';
import 'package:tp1/model/media_model.dart';

class CustomListTile extends StatelessWidget {
  final MediaModel media;
  final Function likedMediaCallback;
  const CustomListTile(
      {super.key, required this.media, required this.likedMediaCallback});

  void _itemLiked() {
    likedMediaCallback(media);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 70,
              child: Image.network(media.imageUrl),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    media.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(media.year.toString()),
                  Text(media.artist),
                ],
              ),
            ),
            IconButton(
              onPressed: _itemLiked,
              icon: const Icon(Icons.favorite_border_rounded),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
