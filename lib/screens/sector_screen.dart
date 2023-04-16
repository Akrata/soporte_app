import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/sector_individual_request.dart';

import '../widgets/custom_card_individual.dart';

class SectorScreen extends StatelessWidget {
  String idSector;
  String nombre;
  SectorScreen({Key? key, required this.idSector, required this.nombre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectorIndividual =
        Provider.of<SectorIndividualRequest>(context, listen: false);
    sectorIndividual.obtenerEquipos(idSector);
    // sectorIndividual.obtenerImpresoras(idSector);
    // sectorIndividual.obtenerPinpad(idSector);
    // sectorIndividual.obtenerTelefonos(idSector);
    // sectorIndividual.obtenerUps(idSector);
    return AlertDialog(
      content: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
          itemCount: sectorIndividual.listaEquipos.length,
          itemBuilder: (BuildContext context, int index) {
            return Text("data");
          },
        ),
      ),
    );
  }
}
