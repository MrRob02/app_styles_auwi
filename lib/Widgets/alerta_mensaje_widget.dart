import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:auwi_styles/Herramientas/constantes.dart';

import 'buttons_shape.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AlertMessageWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool error;
  const AlertMessageWidget(
      {super.key, required this.title, required this.message})
      : error = false;
  const AlertMessageWidget.error(
      {super.key, required this.title, required this.message})
      : error = true;

  @override
  Widget build(BuildContext context) {
    var objBotones = ObjBotones(textoBoton: 'Aceptar', onPressed: Get.back);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Card(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          child: Stack(
            children: [
              Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(error ? Icons.error : Icons.check_circle,
                        color:
                            error ? Colores.colorOrange : Colores.colorPrimario,
                        size: 50),
                    Text(title, style: Styles.titulos),
                    const Gap(20),
                    Text(
                      message,
                      style: Styles.subtitulos,
                      textAlign: TextAlign.center,
                    ),
                    const Gap(15),
                    if (error)
                      ShapeButton.terciario(parametros: objBotones)
                    else
                      ShapeButton.primario(parametros: objBotones)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
