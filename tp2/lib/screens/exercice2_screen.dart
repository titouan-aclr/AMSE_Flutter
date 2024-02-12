import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Ex2ScreenState();
}

class _Ex2ScreenState extends State<Exercice2> {
  double angleRotation = 0; //Angle de rotation déterminé par le slider
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Exercice 2"),
      ),
        body: Column(
          children: [
            Transform.rotate(angle : angleRotation, child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
              child: SizedBox(height :350, width :1000, child: Image.network('https://picsum.photos/512/1024.jpg')),
            )),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Rotation de l'image : "),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Slider(value: angleRotation, min:0 , max:2*pi,  onChanged: (value) {setState(() {
                      angleRotation = value; 
                    });}),
                  ),
                ),
              ],
            )
          ],
        ));


    //throw UnimplementedError();
  }
}
