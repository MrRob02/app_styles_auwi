import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:auwi_styles/Herramientas/constantes.dart';
import '../Widgets/buttons_shape.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AlertMessageWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool error;
  final IconData icon;

  ///onPress y close los estoy colocando porque hay apps que utilizan la navegacion de GetX y otras que usan Bloc entonces no puedo poner uno por defecto
  final Function()? onOkButtonPress;
  final Function() closeDialog;
  const AlertMessageWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.icon,
      required this.closeDialog,
      this.onOkButtonPress})
      : error = false;
  const AlertMessageWidget.error(
      {super.key,
      required this.title,
      required this.message,
      required this.closeDialog,
      this.onOkButtonPress})
      : error = true,
        icon = Icons.error;

  @override
  Widget build(BuildContext context) {
    var objBotones =
        ObjBotones(textoBoton: 'Aceptar', onPressed: onOkButtonPress);
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
                      onPressed: closeDialog,
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon,
                        color: error
                            ? Colores.colorTerciario
                            : Colores.grisSecundario,
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
