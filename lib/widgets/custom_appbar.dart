import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String nombre;
  const CustomAppbar({super.key, required this.nombre});
  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // Define el tamaño preferido de la barra de aplicaciones

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(nombre),
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
    );
  }
}
