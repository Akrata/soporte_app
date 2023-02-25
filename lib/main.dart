import 'package:flutter/material.dart';
import 'package:soporte_app/screens/screens.dart';
import 'package:soporte_app/themes/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Soporte App", textScaleFactor: 2),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), // Creates border
                      color: AppTheme
                          .secondary), //Change background color from here
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  tabs: [
                    Container(
                      child: Tab(
                        text: "Sectores",
                      ),
                    ),
                    Container(
                      child: Tab(
                        text: "Impresoras",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              SectoresScreen(),
              ImpresorasScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
