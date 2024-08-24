import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:auwi_styles/Herramientas/colores.dart';

class BotonTexto extends StatelessWidget {
  final ObjBotonesTexto parametros;

  const BotonTexto({super.key, required this.parametros});

  @override
  Widget build(BuildContext context) {
    var color = traerColor();
    return CupertinoButton(
        alignment: Alignment.centerLeft,
        onPressed: parametros.enabled ? parametros.onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: parametros.mainAxisAlignment,
          children: [
            if (parametros.icono != null) ...[
              Icon(
                parametros.icono,
                color: color,
              ),
              const Gap(15)
            ],
            Text(parametros.textoBoton,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )),
          ],
        ));
  }

  Color traerColor() {
    if (parametros.rawColor != null) {
      return parametros.rawColor!;
    }
    if (parametros.secondary ||
        !parametros.enabled ||
        parametros.onPressed == null) {
      return Colores.grisPrimario;
    }
    if (parametros.alerta) {
      return Colores.colorDarkRed;
    }
    return Colores.colorPrimario;
  }
}

class ObjBotonesTexto {
  final String textoBoton;
  final Function()? onPressed;
  final bool enabled;
  final bool secondary;
  final bool alerta;
  final IconData? icono;
  final MainAxisAlignment mainAxisAlignment;
  final Color? rawColor;

  ObjBotonesTexto(
      {this.secondary = false,
      required this.textoBoton,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.onPressed,
      this.alerta = false,
      this.enabled = true,
      this.icono,
      this.rawColor});
}
