import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/utils/fecha_formater.dart';
import 'package:soporte_app/widgets/searchbar.dart';
import 'package:soporte_app/widgets/widgets.dart';

class SolicitudTonerPage extends StatelessWidget {
  const SolicitudTonerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final solicitudToner = Provider.of<SolicitudTonerRequest>(context);

    final user = Provider.of<AuthWithPass>(context);

    final _data = solicitudToner.listaSolicitudToner;

    return Scaffold(
      body: Column(
        children: [
          // SearchBarCustom(
          //   searchText: solicitudToner.searchText,
          //   actualizar: solicitudToner.getSolicitudToner(),
          //   buscar: solicitudToner.busqueda,
          // ),
          SizedBox(
            height: 20,
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
                        DataCell(Text(data.expand!.sector.nombre)),
                        DataCell(
                            Text(data.expand!.sector.expand!.sucursal.nombre)),
                        DataCell(Text(data.expand!.toner.modelo)),
                        DataCell(Row(
                          children: [
                            Checkbox(
                              onChanged: (value) {
                                //TODO: Realizar la baja de stock
                                // print(user.pb.authStore.model.toString());
                                // if (value == true) {
                                //   solicitudToner.entregarToner(
                                //       data, value!, user.pb.authStore.model.id);
                                //   if (user.usuario.lugarTrabajo ==
                                //       "Policlinico") {
                                //     solicitudToner.entregaTonerSegunLugar(
                                //         data.toner,
                                //         "stock_movil_policlinico",
                                //         data.expand!.toner
                                //                 .stockMovilPoliclinico -
                                //             1);
                                //   } else if (user.usuario.lugarTrabajo ==
                                //       "Sanatorio") {
                                //     solicitudToner.entregaTonerSegunLugar(
                                //         data.toner,
                                //         "stock_movil_sanatorio",
                                //         data.expand!.toner.stockMovilSanatorio -
                                //             1);
                                //   }
                                // } else {
                                //   solicitudToner.entregarToner(
                                //       data, value!, "");
                                // }
                              },
                              value: data.entregado,
                            ),
                            Text(data.expand?.users?.username ?? "")
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FormAgregarSolicitud(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
