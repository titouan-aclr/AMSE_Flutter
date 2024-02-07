import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;
  const CustomNavigationBar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onItemTapped,
    );
  }
}
