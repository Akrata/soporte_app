import 'package:flutter/material.dart';
import 'package:soporte_app/widgets/widgets.dart';

class SectoresScreen extends StatelessWidget {
  const SectoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [CustomSideMenu()],
    );
  }
}
