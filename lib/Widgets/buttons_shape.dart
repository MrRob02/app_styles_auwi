import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:auwi_styles/Herramientas/constantes.dart';

class ShapeButton extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  final ObjBotones parametros;
  final double? elevation;

  const ShapeButton({
    super.key,
    this.elevation,
    required this.backgroundColor,
    required this.textColor,
    required this.parametros,
  });

  const ShapeButton.selected({
    super.key,
    required this.parametros,
    required bool selected,
  })  : backgroundColor = selected ? Colores.colorPrimario : Colors.white,
        textColor = selected ? Colors.white : Colores.grisSecundario,
        elevation = selected ? 0 : 5;

  const ShapeButton.primario({
    super.key,
    required this.parametros,
    this.elevation,
  })  : backgroundColor = Colores.colorPrimario,
        textColor = Colors.white;
  const ShapeButton.secundario({
    super.key,
    required this.parametros,
    this.elevation,
  })  : backgroundColor = Colores.colorBackground,
        textColor = Colores.colorTerciario;

  const ShapeButton.terciario({
    super.key,
    required this.parametros,
    this.elevation,
  })  : backgroundColor = Colores.colorTerciario,
        textColor = Colors.white;

  @override
  State<ShapeButton> createState() => _ShapeButtonState();
}

class _ShapeButtonState extends State<ShapeButton> {
  var contentVisible = true;

  @override
  Widget build(BuildContext context) {
    var color = widget.textColor;
    var ignoring = !(widget.parametros.enabled);
    return IgnorePointer(
      ignoring: ignoring,
      child: Opacity(
        opacity: ignoring ? 0.5 : 1,
        child: Card(
            elevation: widget.elevation,
            shape: RoundedRectangleBorder(
                borderRadius: widget.parametros.borderRadius ??
                    BorderRadius.circular(Styles.bordeFields)),
            color: widget.backgroundColor,
            surfaceTintColor: widget.backgroundColor,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onLongPress: widget.parametros.onLongPressed,
              onTap: widget.parametros.onPressed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.parametros.icono != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.parametros.icono,
                            color: color,
                            size: 20,
                          ),
                          const Gap(15)
                        ],
                      ),
                    Text(widget.parametros.textoBoton,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: color,
                            fontSize: checkSize(),
                            fontWeight: FontWeight.w500,
                            wordSpacing: 2))
                  ],
                ),
              ),
            )),
      ),
    );
  }

  double checkSize() {
    switch (widget.parametros.contentSize) {
      case ContentSize.small:
        return 14;
      case ContentSize.medium:
        return 16;
      case ContentSize.large:
        return 18;
    }
  }
}

enum ContentSize { small, medium, large }

class ObjBotones {
  final String textoBoton;
  final Function()? onPressed;
  final Function()? onLongPressed;
  final bool enabled;
  final IconData? icono;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final ContentSize contentSize;

  ObjBotones(
      {required this.textoBoton,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.onPressed,
      this.onLongPressed,
      this.enabled = true,
      this.icono,
      this.contentSize = ContentSize.medium,
      this.borderRadius});
}
