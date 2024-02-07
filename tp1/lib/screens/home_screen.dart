import 'package:flutter/material.dart';
import 'package:tp1/model/media_model.dart';
import 'package:tp1/widget/custom_list_tile.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<List<MediaModel>> mediaType = [films, series, musics];
  List<MediaModel> likedFilms = List.empty();
  List<MediaModel> likedSeries = List.empty();
  List<MediaModel> likedMusics = List.empty();
  late List<List<MediaModel>> likedMedias;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    likedMedias = [likedFilms, likedSeries, likedMusics];
    super.initState();
  }

  void _likeMediaCallback(MediaModel media) {
    likedMedias[_selectedIndex].add(media);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: mediaType[_selectedIndex].length,
          itemBuilder: (BuildContext context, int index) {
            return CustomListTile(
              media: mediaType[_selectedIndex][index],
              likedMediaCallback: _likeMediaCallback,
            );
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
