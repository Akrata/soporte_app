import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
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

    // sectorIndividual.obtenerImpresoras(idSector);
    // sectorIndividual.obtenerPinpad(idSector);
    // sectorIndividual.obtenerTelefonos(idSector);
    // sectorIndividual.obtenerUps(idSector);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: Text(nombre),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Equipos"),
          FutureBuilder(
            future: sectorIndividual.obtenerEquipos(idSector),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  // height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 100,
                      ),
                      itemCount: sectorIndividual.listaEquipos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCardIndividual(
                            icono: Icons.laptop,
                            ip: sectorIndividual.listaEquipos[index].ip,
                            nombre:
                                sectorIndividual.listaEquipos[index].nombre);
                      },
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          Text("Impresoras"),
          FutureBuilder(
            future: sectorIndividual.obtenerImpresoras(idSector),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  // height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 100,
                      ),
                      itemCount: sectorIndividual.listaImpresoras.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCardIndividual(
                            icono: Icons.print,
                            ip: sectorIndividual.listaImpresoras[index].marca,
                            nombre:
                                sectorIndividual.listaImpresoras[index].modelo);
                      },
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       Text("Equipos"),
      //       Divider(),
      //       Container(
      //         height: 100,
      //         width: double.infinity,
      //         child: GridView.builder(
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 3,
      //           ),
      //           itemCount: listaEquipos.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return CustomCardIndividual(
      //                 icono: Icons.laptop,
      //                 ip: listaEquipos[index].ip,
      //                 nombre: listaEquipos[index].nombre);
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
