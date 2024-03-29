// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/pages/conmutador_page.dart';
import 'package:soporte_app/pages/dashboard_page.dart';
import 'package:soporte_app/pages/equipos_page.dart';
import 'package:soporte_app/pages/impresoras_page.dart';
import 'package:soporte_app/pages/licencia_page.dart';
import 'package:soporte_app/pages/notebook_page.dart';
import 'package:soporte_app/pages/pinpad_page.dart';
import 'package:soporte_app/pages/sector_page.dart';
import 'package:soporte_app/pages/solicitud_toner_page.dart';
import 'package:soporte_app/pages/sucursal_page.dart';
import 'package:soporte_app/pages/telefonos_page.dart';
import 'package:soporte_app/pages/toner_page.dart';
import 'package:soporte_app/pages/ups_page.dart';
import 'package:soporte_app/pages/vpn_page.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:soporte_app/providers/menu/menu_provider.dart';
import 'package:soporte_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthWithPass>(context);
    final menuP = Provider.of<MenuProvider>(context);
    Duration duration = const Duration(milliseconds: 500);
    Curve curve = Curves.ease;
    String lugarSeleccionado = auth.usuario.lugarTrabajo;
    List lugaresTrabajo = ['Policlinico', 'Sanatorio'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Text("Sector de trabajo: "),
              DropdownButton(
                iconEnabledColor: Colors.white,
                focusColor: ThemeData.light().primaryColor,
                dropdownColor: ThemeData.light().primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                value: lugarSeleccionado,
                items: lugaresTrabajo
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e,
                              style: const TextStyle(color: Colors.white)),
                        ))
                    .toList(),
                onChanged: (value) {
                  auth.cambiarSector(auth.usuario.id, value!);
                },
              ),
            ],
          ),
          // Container(
          //   child: IconButton(
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (context) => AlertDialog(
          //           content: Column(),
          //         ),
          //       );
          //     },
          //     icon: Icon(Icons.settings),
          //   ),
          // ),
          const SizedBox(
            width: 30,
          ),
          Container(
            child: IconButton(
                onPressed: () {
                  auth.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                },
                icon: const Icon(Icons.logout_outlined)),
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: Row(
        children: [
          SideMenu(
            page: menuP.page,
            items: [
              SideMenuItems(
                  title: 'Dashboard',
                  onTap: () {
                    menuP.page
                        .animateToPage(0, duration: duration, curve: curve);
                    menuP.selectedPage = 0;
                  },
                  icon: const Icon(Icons.home_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Solicitud de Toners',
                  onTap: () {
                    menuP.page
                        .animateToPage(1, duration: duration, curve: curve);
                    menuP.selectedPage = 1;
                  },
                  icon: const Icon(Icons.add_card_sharp),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Stock Toners',
                  onTap: () {
                    menuP.page
                        .animateToPage(2, duration: duration, curve: curve);
                    menuP.selectedPage = 2;
                  },
                  icon: const Icon(Icons.inventory_sharp),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Sucursales',
                  onTap: () {
                    menuP.page
                        .animateToPage(3, duration: duration, curve: curve);
                    menuP.selectedPage = 3;
                  },
                  icon: const Icon(Icons.insert_page_break_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Sectores',
                  onTap: () {
                    menuP.page
                        .animateToPage(4, duration: duration, curve: curve);
                    menuP.selectedPage = 4;
                  },
                  icon: const Icon(Icons.insert_drive_file_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Equipos',
                  onTap: () {
                    menuP.page
                        .animateToPage(5, duration: duration, curve: curve);
                    menuP.selectedPage = 5;
                  },
                  icon: const Icon(Icons.monitor_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Notebooks',
                  onTap: () {
                    menuP.page
                        .animateToPage(6, duration: duration, curve: curve);
                    menuP.selectedPage = 6;
                  },
                  icon: const Icon(Icons.laptop_mac_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Impresoras',
                  onTap: () {
                    menuP.page
                        .animateToPage(7, duration: duration, curve: curve);
                    menuP.selectedPage = 7;
                  },
                  icon: const Icon(Icons.print_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Ups',
                  onTap: () {
                    menuP.page
                        .animateToPage(8, duration: duration, curve: curve);
                    menuP.selectedPage = 8;
                  },
                  icon: const Icon(Icons.battery_1_bar),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Telefonos',
                  onTap: () {
                    menuP.page
                        .animateToPage(9, duration: duration, curve: curve);
                    menuP.selectedPage = 9;
                  },
                  icon: const Icon(Icons.phone_forwarded_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Pinpads',
                  onTap: () {
                    menuP.page
                        .animateToPage(10, duration: duration, curve: curve);
                    menuP.selectedPage = 10;
                  },
                  icon: const Icon(Icons.credit_card_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Conmutadores',
                  onTap: () {
                    menuP.page
                        .animateToPage(11, duration: duration, curve: curve);
                    menuP.selectedPage = 11;
                  },
                  icon: const Icon(Icons.link),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Licencias',
                  onTap: () {
                    menuP.page
                        .animateToPage(12, duration: duration, curve: curve);
                    menuP.selectedPage = 12;
                  },
                  icon: const Icon(Icons.book_outlined),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'VPN',
                  onTap: () {
                    menuP.page
                        .animateToPage(13, duration: duration, curve: curve);
                    menuP.selectedPage = 13;
                  },
                  icon: const Icon(Icons.account_box_outlined),
                  index: menuP.selectedPage),
            ],
          ),
          Container(
            width: 2,
            height: double.infinity,
            color: Colors.blue[100],
          ),
          Expanded(
            child: PageView(
              controller: menuP.page,
              children: const [
                DashboardPage(),
                SolicitudTonerPage(nombre: "Solicitud de Toners"),
                TonerPage(nombre: "Stock de Toners"),
                SucursalPage(nombre: "Sucursales"),
                SectorPage(nombre: "Sectores"),
                EquiposPage(nombre: "Equipos"),
                NotebookPage(nombre: "Notebooks"),
                ImpresorasPage(nombre: "Impresoras"),
                UpsPage(nombre: "Ups"),
                TelefonosPage(nombre: "Teléfonos"),
                PinpadPage(nombre: "Pinpads"),
                ConmutadorPage(nombre: "Conmutadores"),
                LicenciaPage(nombre: "Licencias"),
                VpnPage(nombre: "VPN"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
