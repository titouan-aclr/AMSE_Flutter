import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

ImageTile tile = ImageTile(
  factor: 0.3,
  alignment: const Alignment(0, 0),
  imageUrl: 'images/test_tiers.png',
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
            child: Image.asset('images/test_tiers.png', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(ImageTile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}
