import 'package:flutter/material.dart';

class SearchBarCustom extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  dynamic Function(bool) enBusqueda;
  dynamic Function(dynamic) buscar;
  dynamic Function() getAll;
  SearchBarCustom({
    required this.enBusqueda,
    required this.buscar,
    required this.getAll,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      decoration: BoxDecoration(),
      child: ListTile(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Buscar',
          ),
          controller: _controller,
        ),
        trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    enBusqueda(true);
                    // equipos.searchText = _controller.text;
                    buscar(_controller.text);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _controller.clear();
                    enBusqueda(false);
                    getAll();
                  },
                  icon: Icon(
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
