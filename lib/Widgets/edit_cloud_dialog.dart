import '../Herramientas/colores.dart';
import '../Herramientas/constantes.dart';
import 'animated_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditCloudDialog extends StatelessWidget {
  const EditCloudDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HeroDialog(
      tag: 'botonInstrucciones',
      positionedChild: Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
            IconButton(onPressed: Get.back, icon: const Icon(Icons.close)),
            row('Existencia en sistema', Icons.cloud_outlined),
            const Gap(10),
            row('Existencia seleccionada', Icons.edit),
            Opacity(
                opacity: 0,
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.abc)))
          ])),
    );
  }

  row(String s, IconData cloud) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s,
          style: Styles.titulos.copyWith(color: Colores.textos, fontSize: 20),
        ),
        const Gap(10),
        Icon(
          cloud,
          color: Colores.colorHint,
        )
      ],
    );
  }
}
