// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class SearchBarCustom extends StatelessWidget {
  final dynamic Function(bool) enBusqueda;
  final dynamic Function(dynamic) buscar;
  final dynamic Function() getAll;
  // String textoBusqueda;
  final TextEditingController controller;
  const SearchBarCustom({
    required this.enBusqueda,
    required this.buscar,
    required this.getAll,
    required this.controller,
    // required this.textoBusqueda,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      decoration: const BoxDecoration(),
      child: ListTile(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Buscar',
          ),
          controller: controller,
        ),
        trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    enBusqueda(true);
                    // equipos.searchText = _controller.text;
                    buscar(controller.text.toLowerCase());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.clear();
                    enBusqueda(false);
                    getAll();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
