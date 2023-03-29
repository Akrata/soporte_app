import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/pages/dashboard_page.dart';
import 'package:soporte_app/pages/solicitud_toner_page.dart';
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

    return Scaffold(
      appBar: AppBar(
        actions: [
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
              children: [
                DashboardPage(),
                SolicitudTonerPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
