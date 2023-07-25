// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CustomCardIndividual extends StatelessWidget {
  final IconData icono;
  final String? ip;
  final String? nombre;
  final String? modelo;
  final String? marca;
  final void Function()? onTap;
  final String? toner;

  const CustomCardIndividual(
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
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  icono,
                  size: 40,
                ),
                Text(
                  ip == null ? '' : '$ip',
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  marca == null ? '' : 'Marca:$marca',
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  toner == null ? '' : 'Toner:$toner',
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
