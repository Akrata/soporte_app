import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/request_providers/toner_request.dart';

class FormRealizarPedido extends StatelessWidget {
  const FormRealizarPedido({super.key});

  @override
  Widget build(BuildContext context) {
    final toner = Provider.of<TonerRequest>(context);
    Map<String, List<int>> pedido = {};
    toner.listaToners.forEach((toner) {
      int faltantePoli =
          toner.stockFijoPoliclinico - toner.stockMovilPoliclinico;
      int faltanteSan = toner.stockFijoSanatorio - toner.stockMovilSanatorio;
      int faltanteTotal = faltantePoli + faltanteSan;
      pedido[toner.modelo] = [faltantePoli, faltanteSan, faltanteTotal];
    });
    return Form(
      child: AlertDialog(
        title: Text("Pedido"),
        content: SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Modelo')),
              DataColumn(label: Text('FaltantePoli')),
              DataColumn(label: Text('FaltanteSan')),
              DataColumn(label: Text('FaltanteTotal')),
            ],
            rows: pedido.entries
                .map((e) => DataRow(cells: [
                      DataCell(
                        Text(e.key),
                      ),
                      DataCell(
                        Text('${e.value[0]}'),
                      ),
                      DataCell(
                        Text('${e.value[1]}'),
                      ),
                      DataCell(
                        Text('${e.value[2]}'),
                      ),
                    ]))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          ),
        ],
      ),
    );
    ;
  }
}
