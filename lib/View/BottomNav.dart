import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String ImagePath;
  final VoidCallback press;
  // final String title;
  const BottomNavItem({
    Key? key,
    required this.ImagePath,
    required this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset(
            ImagePath,
            height: 40,
            width: 150,
          ),
          // Text(
          //   title,
          //   style: const TextStyle(color: Colors.black, fontSize: 13),
          // )
        ],
      ),
    );
  }
}
