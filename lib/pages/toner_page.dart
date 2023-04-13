import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

import 'package:soporte_app/providers/request_providers/toner_request.dart';
import 'package:soporte_app/widgets/form_realizar_pedido.dart';

import '../models/toner.dart';
import '../widgets/form_agregar_toner.dart';

import 'package:url_launcher/url_launcher.dart';

class TonerPage extends StatelessWidget {
  const TonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);
    final _data = toner.listaToners;
    final user = Provider.of<AuthWithPass>(context);

    final String ultravncUrl =
        'file:///C:/Program Files/uvnc bvba/UltraVNC/vncviewer.exe';

    _showDeletePopup(Toner data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Esta intentando eliminar por completo el Toner ${data.modelo}, tanto de Sanatorio como de Policlinico"),
              Text(
                  "Al eliminar el toner, tambien eliminará todas las solicitudes asociadas."),
              Text("Desea continuar?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Canelar"),
            ),
            TextButton(
              onPressed: () {
                toner.deleteToner(data.id);
                Navigator.pop(context);
              },
              child: Text(
                "Eliminar",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    }

    _showEditPopup(Toner data) {
      Toner tonerActual = data;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: user.usuario.lugarTrabajo == "Policlinico"
              ? Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        initialValue: data.modelo,
                        decoration: InputDecoration(labelText: 'Modelo'),
                        onChanged: (value) => tonerActual.modelo = value,
                      ),
                      TextFormField(
                          initialValue: '${data.stockFijoPoliclinico}',
                          onChanged: (value) => tonerActual
                              .stockFijoPoliclinico = int.parse(value),
                          decoration: InputDecoration(
                              labelText: 'Stock Fijo Pol.Cent')),
                      TextFormField(
                          initialValue: '${data.stockMovilPoliclinico}',
                          onChanged: (value) => tonerActual
                              .stockMovilPoliclinico = int.parse(value),
                          decoration: InputDecoration(
                            labelText: 'Stock Movil Pol.Cent',
                          )),
                    ],
                  ),
                )
              : Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        initialValue: data.modelo,
                        decoration: InputDecoration(labelText: 'Modelo'),
                        onChanged: (value) => tonerActual.modelo = value,
                      ),
                      TextFormField(
                        initialValue: '${data.stockFijoSanatorio}',
                        decoration: InputDecoration(labelText: 'Stock Fijo SC'),
                        onChanged: (value) =>
                            tonerActual.stockFijoSanatorio = int.parse(value),
                      ),
                      TextFormField(
                        initialValue: '${data.stockMovilSanatorio}',
                        decoration:
                            InputDecoration(labelText: 'Stock Movil SC'),
                        onChanged: (value) =>
                            tonerActual.stockMovilSanatorio = int.parse(value),
                      ),
                    ],
                  ),
                ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar")),
            ElevatedButton(
                onPressed: () {
                  toner.editToner(tonerActual);
                  print(tonerActual.modelo);
                  Navigator.pop(context);
                },
                child: Text("Confirmar")),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                  onPressed: () async {
                    try {
                      await launch(
                        '"$ultravncUrl 192.1.1.220',
                      );
                    } catch (e) {
                      print('Error al abrir UltraVNC: $e');
                    }
                  },
                  child: Text("vnc")),
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
            ],
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: user.usuario.lugarTrabajo == "Sanatorio"
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Text('Modelo')),
                        DataColumn(label: Text('Stock Fijo SC')),
                        DataColumn(label: Text('Stock Movil SC')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: _data
                          .map(
                            (data) => DataRow(
                              cells: [
                                DataCell(
                                  Text(data.modelo),
                                ),
                                DataCell(Text('${data.stockFijoSanatorio}')),
                                DataCell(Text('${data.stockMovilSanatorio}')),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.amber.shade300),
                                      onPressed: () {
                                        _showEditPopup(data);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade300,
                                      ),
                                      onPressed: () {
                                        _showDeletePopup(data);
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          )
                          .toList(),
                    )
                  : DataTable(
                      columns: const [
                        DataColumn(label: Text('Modelo')),
                        DataColumn(label: Text('Stock Fijo Pol.Cent')),
                        DataColumn(label: Text('Stock Movil Pol.Cent')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: _data
                          .map(
                            (data) => DataRow(
                              cells: [
                                DataCell(
                                  Text(data.modelo),
                                ),
                                DataCell(Text('${data.stockFijoPoliclinico}')),
                                DataCell(Text('${data.stockMovilPoliclinico}')),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,
                                          color: Colors.amber.shade300),
                                      onPressed: () {
                                        _showEditPopup(data);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade300,
                                      ),
                                      onPressed: () {
                                        _showDeletePopup(data);
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => FormAgregarToner(),
            );
          }),
    );
  }
}
