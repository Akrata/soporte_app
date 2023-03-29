import 'package:flutter/material.dart';

class SolicitudTonerPage extends StatelessWidget {
  const SolicitudTonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _data = [
      {'id': 1, 'sector': 'Recepcion', 'sucursal': 'Policlinico'},
      {'id': 2, 'sector': 'Admision Interna', 'sucursal': 'Sanatorio'},
      {'id': 3, 'sector': 'Admision', 'sucursal': 'La paz'},
    ];

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Sector')),
                DataColumn(label: Text('sucursal')),
                DataColumn(label: Text('Acciones')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text(data['id'].toString())),
                        DataCell(Text(data['sector'])),
                        DataCell(Text(data['sucursal'])),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: Colors.amber.shade300),
                                onPressed: () {
                                  // _showEditPopup(data);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade300,
                                ),
                                onPressed: () {
                                  // _showDeletePopup(data);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
