import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

class Exercice5dScreen extends StatelessWidget {
  const Exercice5dScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const int NB_ELEMENTS = 5;

    List<double> computeIndexes(int nbElements) {
      List<double> result = [];
      double temp = 0;

      for (int i = 0; i < nbElements; i++) {
        temp = ((2 * i) / (nbElements - 1)) - 1;
        print(temp);
        result.add(temp);
      }
      return result;
    }

    List<Tile> splitImageIntoTiles(String imageUrl, int nbElements) {
      List<Tile> list = [];
      List<double> indexes = computeIndexes(nbElements);

      for (var y in indexes) {
        for (var x in indexes) {
          print("Position : $x, $y");
          list.add(
            Tile(
              factor: 1 / nbElements,
              alignment: Alignment(x, y),
              imageUrl: imageUrl,
            ),
          );
        }
      }

      return list;
    }

    List<Tile> tiles = splitImageIntoTiles('images/test.jpg', NB_ELEMENTS);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("GridView from count example"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.builder(
            itemCount: NB_ELEMENTS * NB_ELEMENTS,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: NB_ELEMENTS),
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
