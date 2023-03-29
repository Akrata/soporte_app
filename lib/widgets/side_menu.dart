import 'package:flutter/material.dart';
import 'package:soporte_app/widgets/side_menu_items.dart';

class SideMenu extends StatelessWidget {
  List<SideMenuItems> items;
  PageController page;
  SideMenu({super.key, required this.items, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue[100],
      width: 250,
      // color: Colors.black12,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i in items)
            Container(
              width: 200,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: TextButton.icon(
                style: ButtonStyle(alignment: Alignment.centerLeft),
                icon: i.icon,
                label: Text(i.title),
                onPressed: i.onTap,
              ),
            ),
        ],
      ),
    );
  }
}
