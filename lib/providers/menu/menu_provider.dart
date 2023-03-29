import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  PageController page = PageController();
  int selectedPage = 0;
  MenuProvider() {}
}
