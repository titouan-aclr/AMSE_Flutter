import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp1/model/media_model.dart';
import 'package:tp1/widget/custom_list_tile.dart';
import 'package:tp1/widget/custom_navigation_bar.dart';

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 30),
              const Text('Filters : '),
              OutlinedButton.icon(
                onPressed: _toggleFilter,
                icon: Icon(
                  Icons.check,
                  size: filterOn ? 20 : 0,
                ),
                label: const Text('Liked'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
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
