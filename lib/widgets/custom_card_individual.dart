import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardIndividual extends StatelessWidget {
  IconData icono;
  String ip;
  String nombre;
  void Function()? onTap;
  String? toner;

  CustomCardIndividual(
      {super.key,
      required this.icono,
      required this.ip,
      required this.nombre,
      this.onTap,
      this.toner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icono),
                Text(nombre),
                Text(ip),
                Text(toner ?? '')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
