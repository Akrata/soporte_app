import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/pages/dashboard_page.dart';
import 'package:soporte_app/pages/sector_page.dart';
import 'package:soporte_app/pages/solicitud_toner_page.dart';
import 'package:soporte_app/pages/sucursal_page.dart';
import 'package:soporte_app/pages/toner_page.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:soporte_app/providers/menu/menu_provider.dart';
import 'package:soporte_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthWithPass>(context);
    final menuP = Provider.of<MenuProvider>(context);
    Duration duration = Duration(milliseconds: 500);
    Curve curve = Curves.ease;
    String lugarSeleccionado = auth.usuario.lugarTrabajo;
    List lugaresTrabajo = ['Policlinico', 'Sanatorio'];

    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text("Sector de trabajo: "),
              DropdownButton(
                iconEnabledColor: Colors.white,
                focusColor: ThemeData.light().primaryColor,
                dropdownColor: ThemeData.light().primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 25),
                value: lugarSeleccionado,
                items: lugaresTrabajo
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e, style: TextStyle(color: Colors.white)),
                          value: e,
                        ))
                    .toList(),
                onChanged: (value) {
                  auth.cambiarSector(auth.usuario.id, value!);
                },
              ),
            ],
          ),
          Container(
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Column(),
                  ),
                );
              },
              icon: Icon(Icons.settings),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            child: IconButton(
                onPressed: () {
                  auth.logOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'login', (route) => false);
                },
                icon: Icon(Icons.logout_outlined)),
          ),
          SizedBox(
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
                  icon: Icon(Icons.home),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Solicitud de Toners',
                  onTap: () {
                    menuP.page
                        .animateToPage(1, duration: duration, curve: curve);
                    menuP.selectedPage = 1;
                  },
                  icon: Icon(Icons.add_card_sharp),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Stock Toners',
                  onTap: () {
                    menuP.page
                        .animateToPage(2, duration: duration, curve: curve);
                    menuP.selectedPage = 2;
                  },
                  icon: Icon(Icons.inventory_sharp),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Sectores',
                  onTap: () {
                    menuP.page
                        .animateToPage(3, duration: duration, curve: curve);
                    menuP.selectedPage = 3;
                  },
                  icon: const Icon(Icons.insert_drive_file),
                  index: menuP.selectedPage),
              SideMenuItems(
                  title: 'Sucursal',
                  onTap: () {
                    menuP.page
                        .animateToPage(4, duration: duration, curve: curve);
                    menuP.selectedPage = 4;
                  },
                  icon: const Icon(Icons.insert_drive_file),
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
                SolicitudTonerPage(),
                TonerPage(),
                SectorPage(),
                SucursalPage()
              ],
            ),
          )
        ],
      ),
    );
  }
}
