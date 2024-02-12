import 'package:flutter/material.dart';
import 'package:tp1/model/media_model.dart';
import 'package:tp1/widget/custom_list_tile.dart';
import 'package:tp1/screens/about_screen.dart';
import 'package:tp1/widget/custom_navigation_bar.dart';
import 'package:tp1/widget/filters_row.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool filterOn = false;
  List<List<MediaModel>> mediaType = [films, series, musics];
  List<MediaModel> likedFilms = [];
  List<MediaModel> likedSeries = [];
  List<MediaModel> likedMusics = [];
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
    if (likedMedias[_selectedIndex].contains(media)) {
      likedMedias[_selectedIndex].remove(media);
    } else {
      likedMedias[_selectedIndex].add(media);
    }
  }

  void _toggleFilter() {
    setState(() {
      filterOn = !filterOn;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Text('CinéTime',
                      style: TextStyle(color: Color(0xfff9f9f9))))
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.quiz_rounded,
                color: Colors.amber,
              ),
              tooltip: 'Show App Informations',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            )
          ]),
      body: Column(
        children: [
          Container(
            height: 5,
            color: const Color(0xFFFFD400),
          ),
          const SizedBox(height: 5),
          FiltersRow(
            toggleFilter: _toggleFilter,
            filterOn: filterOn,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filterOn
                    ? likedMedias[_selectedIndex].length
                    : mediaType[_selectedIndex].length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomListTile(
                    media: filterOn
                        ? likedMedias[_selectedIndex][index]
                        : mediaType[_selectedIndex][index],
                    toggleMediaLikeCallback: _likeMediaCallback,
                    liked: filterOn
                        ? true
                        : likedMedias[_selectedIndex]
                            .contains(mediaType[_selectedIndex][index]),
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
