import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthWithPass>(context);
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
    );
  }
}
