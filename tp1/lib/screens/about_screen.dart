import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp1/model/media_model.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("About Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50,
          ),
          const SizedBox(
            //width: 1000,
            child: Text(
              'Bienvenue sur notre application. Vous pourrez y retrouver une grande sélection de films, séries et musiques. Vous pouvez essayer de vous ballader entre les différents onglets et aimer les oeuvres que vous préférez.',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 30,
          ),
          const Text(
              "Voici quelques exemples d'oeuvres que vous pourrez rencontrer sur cette application : "),
          //const SizedBox(height: 30),
          Expanded(
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(films[0].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(series[0].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(musics[0].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(films[1].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(series[1].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(musics[1].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(films[2].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(series[2].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(musics[2].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(films[3].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(series[3].imageUrl)),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  height: 50,
                  width: 200,
                  child: Image.network(musics[3].imageUrl)),
              const SizedBox(
                width: 10,
              ),
            ]),
          ),
          Container(
            height: 30,
          )
        ],
      ),
    );
    //Text : 'Bienvenue sur la page about';
  }
}
