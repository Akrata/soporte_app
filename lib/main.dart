import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:soporte_app/providers/auth/auth_with_pass.dart';
import 'package:soporte_app/providers/menu/menu_provider.dart';
import 'package:soporte_app/providers/request_providers/conmutador_request.dart';
import 'package:soporte_app/providers/app_status/app_status_request.dart';
import 'package:soporte_app/providers/request_providers/equipos_request.dart';
import 'package:soporte_app/providers/request_providers/impresoras_request.dart';
import 'package:soporte_app/providers/request_providers/licencia_request.dart';
import 'package:soporte_app/providers/request_providers/notebook_request.dart';
import 'package:soporte_app/providers/request_providers/pinpad_request.dart';
import 'package:soporte_app/providers/request_providers/sector_individual_request.dart';
import 'package:soporte_app/providers/request_providers/sector_request.dart';
import 'package:soporte_app/providers/request_providers/solicitud_toner_request.dart';
import 'package:soporte_app/providers/request_providers/sucursales_request.dart';
import 'package:soporte_app/providers/request_providers/telefono_request.dart';
import 'package:soporte_app/providers/request_providers/toner_request.dart';
import 'package:soporte_app/providers/request_providers/ups_request.dart';
import 'package:soporte_app/providers/request_providers/vpn_request.dart';
import 'package:soporte_app/screens/screens.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  bool status = await AppStatusRequest().fetchData();
  bool serverStatus = await AppStatusRequest().checkServerStatus();
  // print(status);
  WindowOptions windowOptions = const WindowOptions(
    center: true,
    size: Size(1600, 900),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setResizable(false);
    await windowManager.show();
    await windowManager.focus();
  });
  if (status) {
    if (serverStatus) {
      runApp(const StateApp());
    } else {
      runApp(const ServerErrorMainApp());
    }
  } else {
    runApp(const ErrorMainApp());
  }
}

class StateApp extends StatelessWidget {
  const StateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthWithPass(),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SolicitudTonerRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => SucursalesRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImpresorasRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => TonerRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => SectorRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => SectorIndividualRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => EquiposRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpsRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => TelefonoRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => PinpadRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => ConmutadorRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppStatusRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => LicenciaRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotebookRequest(),
        ),
        ChangeNotifierProvider(
          create: (context) => VpnRequest(),
        ),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
      },
    );
  }
}

class ErrorMainApp extends StatelessWidget {
  const ErrorMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => const Scaffold(
        body: Center(
          child: Text("Aplicación deshabilitada",
              style: TextStyle(color: Colors.red, fontSize: 30)),
        ),
      ),
    );
  }
}

class ServerErrorMainApp extends StatelessWidget {
  const ServerErrorMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => const Scaffold(
        body: Center(
          child: Text("El servidor esta offline",
              style: TextStyle(color: Colors.red, fontSize: 30)),
        ),
      ),
    );
  }
}
