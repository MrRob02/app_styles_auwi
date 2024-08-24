import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RutasPackage {
  ///Para abrir este dialog es necesario cubrir el botón que lo activará con un Hero;
  ///
  ///El [child] debe contener antes de la Card (o de cualquier
  ///elemento contenedor del dialog) la clase [HeroWidget].
  ///Una vez hecho eso se colocará el mismo tag del botón en el [tag] del [HeroWidget]
  ///
  ///No es necesario agregar un widget [Material] padre
  static Future<Object?> heroDialog({required Widget child}) async {
    return await Get.to(() => child,
        fullscreenDialog: true, transition: Transition.fade, opaque: false);
  }
}
