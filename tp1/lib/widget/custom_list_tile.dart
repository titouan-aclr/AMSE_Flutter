import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp1/model/media_model.dart';

class CustomListTile extends StatelessWidget {
  final MediaModel medias;
  const CustomListTile({super.key, required this.medias});

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
              child: Image.network(medias.imageUrl),
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
                    medias.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Text(medias.year.toString()),
                  Text(medias.artist),
                ],
              ),
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.favorite_border_rounded),
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
