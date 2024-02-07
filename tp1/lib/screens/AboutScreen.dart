import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("About Page"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            //width: 1000,
            child: Text(
              'Bienvenue sur notre application. Vous pourrez y retrouver une grande sélection de films, séries et musiques. Vous pouvez essayer de vous ballader entre les différents onglets et aimer les oeuvres que vous préférez.',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Text("TEST"),
        ],
      ),
    );
    //Text : 'Bienvenue sur la page about';
  }
}
