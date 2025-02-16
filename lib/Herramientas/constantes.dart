import 'package:flutter/material.dart';
import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:flutter/services.dart';

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
  static const caption = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colores.grisPrimario);
  static const body = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: Colores.grisPrimario);

  static var onlyDecimals =
      TextInputFormatter.withFunction((oldValue, newValue) {
    final text = newValue.text;
    final decimalPattern = RegExp(r'^\d*\.?\d{0,4}$');

    return text.isEmpty
        ? newValue
        : decimalPattern.hasMatch(text)
            ? newValue
            : oldValue;
  });

  static const error = Colores.errorColor;
}
