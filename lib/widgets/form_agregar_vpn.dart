// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soporte_app/providers/request_providers/vpn_request.dart';

import '../models/vpn.dart';

class FormAgregarVpn extends StatelessWidget {
  final bool esEdit;
  final VPN? vpnActual;
  const FormAgregarVpn({super.key, required this.esEdit, this.vpnActual});

  @override
  Widget build(BuildContext context) {
    final vpn = Provider.of<VpnRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Usuario'),
                  initialValue: esEdit ? vpnActual!.usuario : null,
                  onChanged: (value) => esEdit
                      ? vpnActual!.usuario = value
                      : vpn.vpnParaAgregar.usuario = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  initialValue: esEdit ? vpnActual!.password : null,
                  onChanged: (value) => esEdit
                      ? vpnActual!.password = value
                      : vpn.vpnParaAgregar.password = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Contacto'),
                  initialValue: esEdit ? vpnActual!.nombreDeContacto : null,
                  onChanged: (value) => esEdit
                      ? vpnActual!.nombreDeContacto = value
                      : vpn.vpnParaAgregar.nombreDeContacto = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tel'),
                  initialValue: esEdit ? vpnActual!.telefonoDeContacto : null,
                  onChanged: (value) => esEdit
                      ? vpnActual!.telefonoDeContacto = value
                      : vpn.vpnParaAgregar.telefonoDeContacto = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Anydesk'),
                  initialValue: esEdit ? vpnActual!.anydesk : null,
                  onChanged: (value) => esEdit
                      ? vpnActual!.anydesk = value
                      : vpn.vpnParaAgregar.anydesk = value,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () {
                esEdit
                    ? vpn.editVpn(vpnActual!)
                    : vpn.agregarVpn(vpn.vpnParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Confirmar")),
        ],
      ),
    );
  }
}
