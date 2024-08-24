import 'dart:async';
import 'package:auwi_styles/Herramientas/colores.dart';

import 'custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CopyWidget extends StatefulWidget {
  final String textoBoton;
  final String textoCopiado;
  const CopyWidget(
      {super.key, required this.textoBoton, required this.textoCopiado});

  @override
  State<CopyWidget> createState() => _CopyWidgetState();
}

class _CopyWidgetState extends State<CopyWidget> {
  Timer? timer;
  final copied = false.obs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 160,
      child: Obx(() {
        if (copied.isTrue) {
          var color = Colores.grisPrimario;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done_all,
                color: color,
              ),
              Text(
                'Copiado',
                style: TextStyle(color: color),
              ),
            ],
          );
        } else {
          var color = Colores.colorTerciario;
          return CustomCard(
            onTap: copy,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.copy,
                  color: color,
                ),
                const Gap(10),
                Text(
                  widget.textoBoton,
                  style: TextStyle(color: color),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  void copy() {
    copied.value = true;
    Clipboard.setData(ClipboardData(text: widget.textoCopiado));
    timer = Timer(const Duration(seconds: 2), () {
      copied.value = false;
    });
  }
}
