import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardIndividual extends StatelessWidget {
  IconData icono;
  String ip;
  String nombre;
  void Function()? onTap;

  CustomCardIndividual({
    super.key,
    required this.icono,
    required this.ip,
    required this.nombre,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Card(
          child: Center(
            child: Column(
              children: [
                Icon(icono),
                Text(nombre),
                Text(ip),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
