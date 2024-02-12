import 'package:flutter/material.dart';

class FiltersRow extends StatelessWidget {
  final Function()? toggleFilter;
  final bool filterOn;
  const FiltersRow({super.key, this.toggleFilter, required this.filterOn});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 100),
        const Text('Filters : ', style: TextStyle(color: Color(0xfff9f9f9)),),
        OutlinedButton.icon(
          onPressed: toggleFilter,
          icon: Icon(
            Icons.check,
            size: filterOn ? 20 : 0,
          ),
          label: const Text('Liked', style: TextStyle(color: Color(0xfff9f9f9))),

        ),
      ],
    );
    
  }
}
