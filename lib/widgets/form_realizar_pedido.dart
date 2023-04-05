import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/request_providers/toner_request.dart';

import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FormRealizarPedido extends StatelessWidget {
  FormRealizarPedido({super.key});

  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 1.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
    SnackBar(content: Text("Exportado con exito"));
  }

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
          child: RepaintBoundary(
            key: _printKey,
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text('Modelo'),
                ),
                DataColumn(label: Text('Faltante Policlinico')),
                DataColumn(label: Text('Faltante Sanatorio')),
                DataColumn(label: Text('Faltante Total')),
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
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          ),
          TextButton(
            onPressed: _printScreen,
            child: Text("Exportar"),
          ),
        ],
      ),
    );
    ;
  }
}
