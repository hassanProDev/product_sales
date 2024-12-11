import 'package:flutter/material.dart';

class BottomNavButton extends StatelessWidget {
  void Function()? onPressed;
  Color? backgroundColor;
  Color? color;
  String label;
  IconData icon;

  BottomNavButton(
      {super.key,
      this.onPressed,
      required this.label,
      required this.icon,
      this.backgroundColor,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
