import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp1/model/media_model.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
  
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  Widget build(BuildContext context) {
    List<MediaModel> getConcatenedList() {
      List<MediaModel> concatenedList = [];
      List<List<MediaModel>> lists = [films, series, musics];
      int max = lists.map((list) => list.length).reduce((max, length) => max > length ? max : length);

      for (int i = 0; i<max; i++){
        if(films.length>i){
          concatenedList.add(films[i]);
        }
        if(series.length>i){
          concatenedList.add(series[i]);
        }
        if(musics.length>i){
          concatenedList.add(musics[i]); 
        }
      }
      return concatenedList;
    }

  List<MediaModel> listMedias = getConcatenedList();

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
            child: ListView.builder(
              itemCount: series.length + films.length + musics.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      height: 50,
                      width: 200,
                      child: Image.network(listMedias[index].imageUrl)),
                );
              },
            ),
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
