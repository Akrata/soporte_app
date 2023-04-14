import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/sector_individual_request.dart';

import '../widgets/custom_card_individual.dart';

class SectorScreen extends StatelessWidget {
  String idSector;
  SectorScreen({Key? key, required this.idSector}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectorIndividual = Provider.of<SectorIndividualRequest>(context);
    sectorIndividual.obtenerEquipos(idSector);
    sectorIndividual.obtenerImpresoras(idSector);
    sectorIndividual.obtenerPinpad(idSector);
    sectorIndividual.obtenerTelefonos(idSector);
    sectorIndividual.obtenerUps(idSector);
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("Equipos"),
            Divider(),
            CustomCardIndividual(
                icono: Icons.laptop,
                ip: sectorIndividual.listaEquipos[0].ip,
                nombre: sectorIndividual.listaEquipos[0].nombre)
          ],
        ),
      ),
    );
  }
}
