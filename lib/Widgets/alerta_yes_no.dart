library dialogs;

import '../Herramientas/colores.dart';
import 'boton_texto.dart';
import 'buttons_shape.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class YesNoAlert extends StatelessWidget {
  final String title;
  final String content;
  const YesNoAlert(
      {super.key,
      this.title = '¿Estás seguro?',
      this.content = 'Esta acción no se puede deshacer'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              Text(
                content,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colores.grisPrimario,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BotonTexto(
                    parametros: ObjBotonesTexto(
                      textoBoton: 'Si',
                      onPressed: () => Get.back(result: true),
                    ),
                  ),
                  const Gap(20),
                  SizedBox(
                    width: 100,
                    child: ShapeButton.primario(
                      parametros: ObjBotones(
                          textoBoton: 'No',
                          onPressed: () => Get.back(result: false)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
