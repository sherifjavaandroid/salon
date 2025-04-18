import 'package:flutter/material.dart';

class HomeText {
  final String title;
  final IconData icon;
  final Color color;
  final void Function() taped;

  HomeText({
    required this.title,
    required this.icon,
    required this.color,
    required this.taped,
  });
}
