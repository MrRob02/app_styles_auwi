import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandSeparator extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    int newInt = int.tryParse(newText) ?? 0;
    var selectionIndexFromTheRight =
        newValue.text.length - newValue.selection.end;

    //?Este numberformat viene de la libreria intl
    String newString = NumberFormat("#,##0").format(newInt);

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndexFromTheRight,
      ),
    );
  }
}
