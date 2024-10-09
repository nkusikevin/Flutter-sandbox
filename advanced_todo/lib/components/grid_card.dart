import 'package:flutter/material.dart';

class GridCard extends StatefulWidget {
  final String title;
  final String description;
  final icon;
  final Color color;
  const GridCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon,
      required this.color});

  @override
  State<GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<GridCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            widget.description,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
