import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

class Exercice5cScreen extends StatelessWidget {
  const Exercice5cScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ImageTile> splitImageIntoTiles(String imageUrl) {
      List<ImageTile> list = [];

      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          list.add(
            ImageTile(
              id: 0,
              factor: 1 / 3,
              alignment: Alignment(j.toDouble(), i.toDouble()),
              imageUrl: imageUrl,
              empty: false,
            ),
          );
        }
      }

      return list;
    }

    List<ImageTile> tiles = splitImageIntoTiles('images/test.jpg');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GridView from count example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(1.0),
                child: tiles[index].croppedImageTile(),
              );
            },
          ),
        ),
      ),
    );
  }
}
