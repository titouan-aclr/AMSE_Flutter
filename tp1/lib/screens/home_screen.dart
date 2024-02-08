import 'package:flutter/material.dart';
import 'package:tp1/model/media_model.dart';
import 'package:tp1/widget/custom_list_tile.dart';
import 'package:tp1/screens/about_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<List<MediaModel>> mediaType = [films, series, musics];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.quiz_rounded),
            tooltip: 'Show App Informations',
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            );
            },
          )
        ]
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: films.length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListTile(medias: mediaType[_selectedIndex][index]);
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies_rounded),
            label: 'Films',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Séries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Musiques',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
