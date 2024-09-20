import 'package:flutter/material.dart';

class CustomStaggeredTile extends StatelessWidget {
  final String imagePath;
  final String text;

  const CustomStaggeredTile(
      {Key? key, required this.imagePath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}
