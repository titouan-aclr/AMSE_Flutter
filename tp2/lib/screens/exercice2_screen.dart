import 'dart:math';
import 'package:flutter/material.dart';

class Exercice2 extends StatefulWidget {
  const Exercice2({super.key});

  @override
  State<Exercice2> createState() => _Ex2ScreenState();
}

class _Ex2ScreenState extends State<Exercice2>
    with SingleTickerProviderStateMixin {
  double angleRotationX = 0;
  double angleRotationZ = 0;
  double dimension = 1;
  bool limite_X = false; 
  bool limite_Z = false; 
  bool limite_dim = false; 
 
  late AnimationController animations;

  @override
  void initState() {
    super.initState();
    animations = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 50))
      ..addListener(() {
        setState(() {
          animation();
        });
        ();
      });
  }

  void animation() {
    double valueChangementX = 0.02; 
    double valueChangementZ = 0.03; 
    double valueChangementDim = 0.01; 


    if (angleRotationX + valueChangementX < 2 * pi && limite_X == false) {
      angleRotationX += valueChangementX;
    } 
    else if (angleRotationX - valueChangementX > 0 && limite_X == true){
      angleRotationX -= valueChangementX;
    }
    else if(angleRotationX - valueChangementX < 0 && limite_X == true){
      limite_X = false; 
    }
    else if (angleRotationX + valueChangementX > 2 * pi && limite_X == false) {
      limite_X = true; 
    }

    if (angleRotationZ + valueChangementZ < 2 * pi && limite_Z == false) {
      angleRotationZ += valueChangementZ;
    } 
    else if (angleRotationZ - valueChangementZ > 0 && limite_Z == true){
      angleRotationZ -= valueChangementZ;
    }
    else if(angleRotationZ - valueChangementZ < 0 && limite_Z == true){
      limite_Z = false; 
    }
    else if (angleRotationZ + valueChangementZ > 2 * pi && limite_Z == false) {
      limite_Z = true; 
    }

    if (dimension + valueChangementDim < 1.5 && limite_dim == false) {
      dimension += valueChangementDim;
    } 
    else if (dimension + valueChangementDim > 0.2 && limite_dim == true) {
      dimension -= valueChangementDim;
    } 
    else if(dimension - valueChangementDim < 0.2 && limite_dim == true){
      limite_dim = false; 
    }
    else if (dimension + valueChangementDim > 1.5 && limite_dim == false) {
      limite_dim = true; 
    }

  }

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
                  ..rotateZ(angleRotationZ)
                  ..scale(dimension),
                alignment: Alignment.center,
                //angle: angleRotation,
                child: SizedBox(
                    height: 350,
                    width: 1000,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
                      child:
                          Image.network('https://picsum.photos/512/1024.jpg'),
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
                        max: 2,
                        onChanged: (value) {
                          setState(() {
                            dimension = value;
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
                  child: Text("Lancement de la cinématique :"),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (animations.isAnimating) {
                            animations.stop();
                          } else {
                            animations.repeat();
                          }
                        });
                      },
                      child: Text(
                        animations.isAnimating
                            ? 'Arrêter l\'animation'
                            : 'Démarrer l\'animation',
                      ),
                    )),
              ],
            )
          ],
        ));
  }
}
