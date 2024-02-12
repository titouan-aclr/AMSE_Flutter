import 'dart:math';

import 'package:flutter/material.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Ex2ScreenState();
}

class _Ex2ScreenState extends State<Exercice2> {
  //double angleRotation = 0; //Angles de rotation déterminés par les sliders
  double angleRotationX = 0;
  double angleRotationZ = 0;
  double dimension = 10; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Exercice 2"),
        ),
        body: Column(
          children: [
            Transform(
                transform: Matrix4.rotationX(angleRotationX)
                  ..rotateZ(angleRotationZ)..scale(dimension),
                  alignment: Alignment.center,
                //angle: angleRotation,
                child: SizedBox(
                    height: 350,
                    width: 1000,
                    child:
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
                          child: Image.network('https://picsum.photos/512/1024.jpg'),
                        ))),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Rotation de l'image selon X : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                    child: Slider(
                        value: angleRotationX,
                        min: 0,
                        max: 2 * pi,
                        onChanged: (value) {
                          setState(() {
                            angleRotationX = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Rotation de l'image selon Z : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Slider(
                        value: angleRotationZ,
                        min: 0,
                        max: 2 * pi,
                        onChanged: (value) {
                          setState(() {
                            angleRotationZ = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Changement de taille : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Slider(
                        value: dimension,
                        min: 0.1,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            dimension = value;
                          });
                        }),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
