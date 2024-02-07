import 'package:flutter/material.dart';
import 'package:tp1/model/media_model.dart';

// ignore: must_be_immutable
class CustomListTile extends StatefulWidget {
  final MediaModel media;
  final Function toggleMediaLikeCallback;
  bool liked;
  CustomListTile(
      {super.key,
      required this.media,
      required this.toggleMediaLikeCallback,
      required this.liked});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void _itemLiked() {
    setState(() {
      widget.liked = !widget.liked;
    });
    widget.toggleMediaLikeCallback(widget.media);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.25),
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
              child: Image.network(widget.media.imageUrl),
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
                    widget.media.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(widget.media.year.toString()),
                  Text(widget.media.artist),
                ],
              ),
            ),
            IconButton(
              onPressed: _itemLiked,
              icon: Icon(
                color: Colors.amber[800],
                widget.liked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
              ),
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
