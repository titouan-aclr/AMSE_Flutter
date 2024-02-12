import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

Tile tile = Tile(
  imageURL: 'https://picsum.photos/512',
  factor: 0.3,
  alignment: const Alignment(0, 0), // Au milieu de l'image
);

class Exercice4a extends StatelessWidget {
  const Exercice4a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Exercice 4a"),
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: const EdgeInsets.all(20.0),
                child: createTileWidgetFrom(tile))),
        SizedBox(
            height: 200,
            child:
                Image.network('https://picsum.photos/512', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
