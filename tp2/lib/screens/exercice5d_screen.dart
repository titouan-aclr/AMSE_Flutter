import 'package:flutter/material.dart';
import 'package:tp2/widgets/image_tile.dart';

class Exercice5dScreen extends StatefulWidget {
  const Exercice5dScreen({super.key});

  @override
  State<Exercice5dScreen> createState() => _Exercice5dScreenState();
}

class _Exercice5dScreenState extends State<Exercice5dScreen> {
  double NB_ELEMENTS = 5;

  @override
  Widget build(BuildContext context) {
    List<double> computeIndexes() {
      List<double> result = [];
      double temp = 0;

      for (int i = 0; i < NB_ELEMENTS; i++) {
        temp = ((2 * i) / (NB_ELEMENTS - 1)) - 1;
        result.add(temp);
      }
      return result;
    }

    List<ImageTile> splitImageIntoTiles(String imageUrl) {
      List<ImageTile> list = [];
      List<double> indexes = computeIndexes();

      for (var y in indexes) {
        for (var x in indexes) {
          list.add(
            ImageTile(
              factor: 1 / NB_ELEMENTS,
              alignment: Alignment(x, y),
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
      body: Column(
        children: [
          Center(
            child: Container(
              height: 500,
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: (NB_ELEMENTS * NB_ELEMENTS).toInt(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: NB_ELEMENTS.toInt()),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(1.0),
                    child: tiles[index].croppedImageTile(),
                  );
                },
              ),
            ),
          ),
          Slider(
            value: NB_ELEMENTS,
            onChanged: (newNbElements) =>
                setState(() => NB_ELEMENTS = newNbElements),
            min: 2,
            divisions: 6,
            max: 8,
            label: NB_ELEMENTS.round().toString(),
          )
        ],
      ),
    );
  }
}
