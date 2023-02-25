import 'package:flutter/material.dart';
import 'package:soporte_app/themes/app_theme.dart';

class CustomSideMenu extends StatelessWidget {
  const CustomSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      width: 200,
      height: double.infinity,
      color: AppTheme.secondary,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text("Agregar Sector"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Agregar Sector"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Agregar Sector"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Agregar Sector"),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
