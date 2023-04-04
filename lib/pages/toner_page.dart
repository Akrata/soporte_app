import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:soporte_app/providers/request_providers/toner_request.dart';
import 'package:soporte_app/widgets/form_realizar_pedido.dart';

class TonerPage extends StatelessWidget {
  const TonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);
    final _data = toner.listaToners;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FormRealizarPedido(),
                );
              },
              child: Text("Realizar Pedido"),
            ),
            height: 50,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Modelo')),
                  DataColumn(label: Text('Stock Movil Pol')),
                  DataColumn(label: Text('Stock Fijo Pol')),
                  DataColumn(label: Text('Stock Movil SC')),
                  DataColumn(label: Text('Stock Fijo SC')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: _data
                    .map(
                      (data) => DataRow(
                        cells: [
                          DataCell(
                            Text(data.modelo),
                          ),
                          DataCell(Text('${data.stockMovilPoliclinico}')),
                          DataCell(Text('${data.stockFijoPoliclinico}')),
                          DataCell(Text('${data.stockMovilSanatorio}')),
                          DataCell(Text('${data.stockFijoSanatorio}')),
                          DataCell(Row(
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
                                  // _showDelete Popup(data);
                                },
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
