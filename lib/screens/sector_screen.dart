import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/models/equipo.dart';
import 'package:soporte_app/providers/request_providers/sector_individual_request.dart';

import '../widgets/custom_card_individual.dart';

class SectorScreen extends StatelessWidget {
  final String idSector;
  final String nombre;
  const SectorScreen({Key? key, required this.idSector, required this.nombre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sectorIndividual =
        Provider.of<SectorIndividualRequest>(context, listen: false);

    // sectorIndividual.obtenerPinpad(idSector);

    // sectorIndividual.obtenerUps(idSector);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: Text(nombre),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Text(
                "Equipos",
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline),
              ),
              Container(
                height: 320,
                child: FutureBuilder(
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
                              crossAxisCount: 5,
                              mainAxisExtent: 150,
                            ),
                            itemCount: sectorIndividual.listaEquipos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCardIndividual(
                                  icono: Icons.laptop,
                                  ip: sectorIndividual.listaEquipos[index].ip,
                                  nombre: sectorIndividual
                                      .listaEquipos[index].nombre);
                            },
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Text(
                "Impresoras",
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline),
              ),
              Container(
                height: 320,
                child: FutureBuilder(
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
                              crossAxisCount: 5,
                              mainAxisExtent: 150,
                            ),
                            itemCount: sectorIndividual.listaImpresoras.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCardIndividual(
                                icono: Icons.print,
                                marca: sectorIndividual
                                    .listaImpresoras[index].marca,
                                modelo: sectorIndividual
                                    .listaImpresoras[index].modelo,
                                toner: sectorIndividual.listaImpresoras[index]
                                    .expand!.toner!.modelo,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Text(
                "Telefono",
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline),
              ),
              Container(
                height: 320,
                child: FutureBuilder(
                  future: sectorIndividual.obtenerTelefonos(idSector),
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
                              crossAxisCount: 5,
                              mainAxisExtent: 150,
                            ),
                            itemCount: sectorIndividual.listaTelefonos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCardIndividual(
                                nombre: sectorIndividual
                                    .listaTelefonos[index].interno
                                    .toString(),
                                icono: Icons.phone,
                                ip: sectorIndividual.listaTelefonos[index].ip,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Text(
                "Ups",
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline),
              ),
              Container(
                height: 320,
                child: FutureBuilder(
                  future: sectorIndividual.obtenerUps(idSector),
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
                              crossAxisCount: 5,
                              mainAxisExtent: 150,
                            ),
                            itemCount: sectorIndividual.listaUps.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCardIndividual(
                                icono: Icons.battery_charging_full_outlined,
                                modelo: sectorIndividual.listaUps[index].modelo,
                                marca: sectorIndividual.listaUps[index].marca,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Text(
                "Pinpad",
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline),
              ),
              Container(
                height: 320,
                child: FutureBuilder(
                  future: sectorIndividual.obtenerPinpad(idSector),
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
                              crossAxisCount: 5,
                              mainAxisExtent: 150,
                            ),
                            itemCount: sectorIndividual.listaPinpad.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCardIndividual(
                                nombre: sectorIndividual.listaPinpad[index].ip
                                    .toString(),
                                icono: Icons.credit_card,
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
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
