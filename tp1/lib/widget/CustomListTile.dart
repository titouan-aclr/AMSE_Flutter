import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  const CustomListTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: Image.network(
                  'https://cdns-images.dzcdn.net/images/cover/974997a0db8d1d0c2de1ebde4275997f/350x350.jpg'),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text),
                  const Text("Year"),
                  const Text("Artist"),
                ],
              ),
            ),
            const IconButton(
              onPressed: null,
              icon: Icon(Icons.favorite_border_rounded),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
