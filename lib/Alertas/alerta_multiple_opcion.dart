import 'package:auwi_styles/Widgets/custom_text.dart';
import 'package:auwi_styles/auwi_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';

enum EnumEstiloPreferido { firstPreferred, secondPreferred, none, both }

class AlertaMultipleOpcion<T> extends StatelessWidget {
  final bool secondPreferred;
  final String title;
  final String message;
  final IconData icon;
  final ObjBotonesTexto firstButton;
  final ObjBotones? secondButton;
  final ObjBotonesTexto? seccondTextButton;
  const AlertaMultipleOpcion(
      {super.key,
      this.secondPreferred = false,
      required this.title,
      required this.message,
      required this.icon,
      required this.firstButton,
      required ObjBotonesTexto secondButton})
      : secondButton = null,
        seccondTextButton = secondButton;
  const AlertaMultipleOpcion.secondPreferred({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.firstButton,
    required this.secondButton,
  })  : secondPreferred = true,
        seccondTextButton = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomCard(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colores.grisPrimario,
            size: 50,
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText.title(
              title,
            ),
          ),
          const Gap(10),
          CustomText(
            message,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BotonTexto(
                parametros: firstButton,
              ),
              if (secondPreferred)
                ShapeButton.primario(parametros: secondButton!)
              else
                BotonTexto(
                  parametros: seccondTextButton!,
                ),
            ],
          ),
        ],
      )),
    );
  }
}
