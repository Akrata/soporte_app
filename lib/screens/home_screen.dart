import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthWithPass>(context);
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              auth.logOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            child: Text("LogOut")),
      ),
    );
  }
}
