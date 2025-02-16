library dialogs;

import '../Herramientas/colores.dart';
import '../Widgets/boton_texto.dart';
import '../Widgets/buttons_shape.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class YesNoAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function(bool?) backFunction;
  final IconData? icon;
  const YesNoAlert(
      {super.key,
      required this.backFunction,
      this.icon,
      this.title = '¿Estás seguro?',
      this.content = 'Esta acción no se puede deshacer'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      color: Colores.colorPrimario,
                    ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
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
                          onPressed: () => backFunction(true),
                        ),
                      ),
                      const Gap(20),
                      ShapeButton.primario(
                        parametros: ObjBotones(
                            textoBoton: 'No',
                            onPressed: () => backFunction(false)),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    color: Colores.textos,
                    onPressed: () => backFunction(null),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
