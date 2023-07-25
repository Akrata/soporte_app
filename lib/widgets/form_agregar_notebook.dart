// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/notebook.dart';
import '../providers/request_providers/notebook_request.dart';

class FormAgregarNotebook extends StatelessWidget {
  final bool esEdit;
  final Notebook? notebookActual;
  const FormAgregarNotebook(
      {super.key, required this.esEdit, this.notebookActual});

  @override
  Widget build(BuildContext context) {
    final notebook = Provider.of<NotebookRequest>(context);

    return Form(
      child: AlertDialog(
        content: Form(
          child: Container(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Marca'),
                  initialValue: esEdit ? notebookActual!.marca : null,
                  onChanged: (value) => esEdit
                      ? notebookActual!.marca = value
                      : notebook.notebookParaAgregar.marca = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  initialValue: esEdit ? notebookActual!.modelo : null,
                  onChanged: (value) => esEdit
                      ? notebookActual!.modelo = value
                      : notebook.notebookParaAgregar.modelo = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Año'),
                  initialValue: esEdit ? notebookActual!.anio : null,
                  onChanged: (value) => esEdit
                      ? notebookActual!.anio = value
                      : notebook.notebookParaAgregar.anio = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Usuario'),
                  initialValue: esEdit ? notebookActual!.usuario : null,
                  onChanged: (value) => esEdit
                      ? notebookActual!.usuario = value
                      : notebook.notebookParaAgregar.usuario = value,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Telefono de Contacto'),
                  initialValue:
                      esEdit ? notebookActual!.telefonoDeContacto : null,
                  onChanged: (value) => esEdit
                      ? notebookActual!.telefonoDeContacto = value
                      : notebook.notebookParaAgregar.telefonoDeContacto = value,
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
                    ? notebook.editNotebook(notebookActual!)
                    : notebook.agregarNotebook(notebook.notebookParaAgregar);

                Navigator.pop(context);
              },
              child: const Text("Confirmar")),
        ],
      ),
    );
  }
}
