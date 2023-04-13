import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  // Properties
  final String title;
  final String subtitle;
  final String iconUrl;

  // Constructor
  const ListItem({
      required this.title,
      required this.subtitle,
      required this.iconUrl,
      Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3)
            )
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.greenAccent, width: 5),
            ),
          ),
          child: ListTile(
              leading: Image.asset(iconUrl),
              title: Text(title, style: const TextStyle(fontSize: 18.0)),
              subtitle: Text(subtitle)
          ),
        ),
      )
    );
  }
}


