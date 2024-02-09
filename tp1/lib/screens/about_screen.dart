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
      int max = lists
          .map((list) => list.length)
          .reduce((max, length) => max > length ? max : length);

      for (int i = 0; i < max; i++) {
        if (films.length > i) {
          concatenedList.add(films[i]);
        }
        if (series.length > i) {
          concatenedList.add(series[i]);
        }
        if (musics.length > i) {
          concatenedList.add(musics[i]);
        }
      }
      return concatenedList;
    }

    List<MediaModel> listMedias = getConcatenedList();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF363636),
          title: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      height: 30, child: Image.asset('images/logo.jpg'))),
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Informations à propos de CinéTime',
                      style: TextStyle(color: Color(0xfff9f9f9))))
            ],
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5,
            color: const Color(0xFFFFD400),
          ),
          const SizedBox(height: 15),
          const SizedBox(
            height: 45,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Text(
                'Bienvenue sur notre application.\n Vous pourrez y retrouver une grande sélection de films, séries et musiques. Vous pouvez essayer de vous ballader entre les différents onglets et aimer les oeuvres que vous préférez.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xfff9f9f9)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
              "Voici quelques exemples d'oeuvres que vous pourrez rencontrer sur cette application : ",
              style: TextStyle(color: Color(0xfff9f9f9))),
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
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
