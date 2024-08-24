import 'package:flutter/material.dart';
import 'package:auwi_styles/Herramientas/colores.dart';

class Styles {
  static const double bordeFields = 30;
  static const subtitulos =
      TextStyle(color: Colores.grisPrimario, fontSize: 20);

  static const estiloTextoTerciario =
      TextStyle(color: Colores.grisPrimario, fontSize: 16);

  static const titulos = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w500, color: Colores.grisPrimario);
  static const estiloMensajes = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: Colores.grisPrimario);
  static const mensajesALerta = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w600, color: Colores.colorTerciario);
}
