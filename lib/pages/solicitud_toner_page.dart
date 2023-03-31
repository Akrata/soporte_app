import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/utils/fecha_formater.dart';

class SolicitudTonerPage extends StatelessWidget {
  const SolicitudTonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudToner = Provider.of<SolicitudTonerRequest>(context);
    final listaSucursales = Provider.of<SucursalesRequest>(context);
    final user = Provider.of<AuthWithPass>(context);

    final _data = solicitudToner.listaSolicitudToner;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
                child: DataTable(
              columns: const [
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Sector')),
                DataColumn(label: Text('Sucursal')),
                DataColumn(label: Text('Toner')),
                DataColumn(label: Text('Entregado')),
              ],
              rows: _data
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(
                          Text(FechaFormater.formatearFecha(
                              data.created.toString())),
                        ),
                        DataCell(Text(data.expand.sector.nombre)),
                        DataCell(
                            Text(data.expand.sector.expand.sucursal.nombre)),
                        DataCell(Text(data.expand.toner.modelo)),
                        DataCell(Row(
                          children: [
                            Checkbox(
                              onChanged: (value) {
                                print(user.pb.authStore.model.toString());
                                if (value == true) {
                                  solicitudToner.entregarToner(
                                      data, value!, user.pb.authStore.model.id);
                                } else {
                                  solicitudToner.entregarToner(
                                      data, value!, "");
                                }
                              },
                              value: data.entregado,
                            ),
                            Text(data.expand.users?.username ?? "")
                          ],
                        )),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
