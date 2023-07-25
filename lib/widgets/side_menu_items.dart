import 'package:flutter/material.dart';

class SideMenuItems {
  final String title;
  final int index;
  final Icon icon;
  final dynamic Function() onTap;
  SideMenuItems(
      {required this.title,
      required this.onTap,
      required this.icon,
      required this.index});
}
