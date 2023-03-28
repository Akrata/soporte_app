import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final auth = Provider.of<AuthWithPass>(context);

    String usuario = "";
    String contrasena = "";
    return Scaffold(
      body: Form(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            height: 280,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Usuario",
                    contentPadding: EdgeInsets.all(5),
                  ),
                  onChanged: (value) => usuario = value,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    contentPadding: EdgeInsets.all(5),
                  ),
                  onChanged: (value) => contrasena = value,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      await auth.authUser(usuario, contrasena);
                      if (auth.isAuth) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', (route) => false);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.red[100],
                            content: Text(
                              "Usuario o contraseña incorrecta",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Ingresar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
