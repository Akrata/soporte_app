import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardIndividual extends StatelessWidget {
  IconData icono;
  String? ip;
  String? nombre;
  String? modelo;
  String? marca;
  void Function()? onTap;
  String? toner;

  CustomCardIndividual(
      {super.key,
      required this.icono,
      this.ip,
      this.nombre,
      this.marca,
      this.modelo,
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
                Text(
                  nombre == null ? '$modelo' : '$nombre',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  icono,
                  size: 40,
                ),
                Text(
                  ip == null ? '' : '$ip',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  marca == null ? '' : 'Marca:$marca',
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  toner == null ? '' : 'Toner:$toner',
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
