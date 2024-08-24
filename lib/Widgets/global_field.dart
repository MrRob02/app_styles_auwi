import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Herramientas/colores.dart';
import '../Herramientas/constantes.dart';

class GlobalField extends StatefulWidget {
  final bool enabled;
  final bool isPassword;
  final int? maxLength;
  final bool showCounter;
  final String hint;
  final TextInputAction? inputAction;
  final TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final String? Function(String)? validator;
  final Function()? onEditingCompleted;
  final TextInputType textInputType;
  final List<String>? autoFillType;
  final TextAlign textAlign;
  final Function(bool)? onFocusChange;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool automaticUnfocus;
  final BotonDerecho? suffixButton;

  const GlobalField(
      {super.key,
      required this.hint,
      required this.textController,
      this.autoFillType,
      this.automaticUnfocus = true,
      this.enabled = true,
      this.focusNode,
      this.inputAction,
      this.inputFormatters,
      this.isPassword = false,
      this.maxLength,
      this.maxLines,
      this.onChanged,
      this.onEditingCompleted,
      this.onFieldSubmitted,
      this.onFocusChange,
      this.showCounter = false,
      this.suffixButton,
      this.textAlign = TextAlign.start,
      this.textInputType = TextInputType.text,
      this.validator});

  @override
  State<GlobalField> createState() => _GlobalFieldState();
}

class _GlobalFieldState extends State<GlobalField> {
  var textVisible = false;
  late final FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    if (widget.isPassword && widget.suffixButton != null) {
      throw Exception(
          'No se puede tener un campo de contraseña con un botón derecho');
    }
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var borde = BorderRadius.circular(Styles.bordeFields);

    final defaultBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: borde,
    );
    final focusedBoderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Colores.colorPrimario, width: 2),
      borderRadius: borde,
    );

    final errorBoderStyle = OutlineInputBorder(
      borderSide: const BorderSide(color: Colores.colorDarkRed),
      borderRadius: borde,
    );

    final inputDecoration = InputDecoration(
        counterText: widget.showCounter ? null : '',
        hintText: widget.hint,
        errorBorder: errorBoderStyle,
        focusedErrorBorder: errorBoderStyle,
        disabledBorder: defaultBorder,
        focusedBorder: focusedBoderStyle,
        enabledBorder: defaultBorder,
        errorStyle: const TextStyle(fontSize: 15),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: widget.isPassword
            ? textVisible
                ? IconButton(
                    icon: Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        textVisible = false;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        textVisible = true;
                      });
                    },
                  )
            : widget.suffixButton != null
                ? IconButton(
                    icon: Icon(widget.suffixButton!.icono),
                    onPressed: widget.suffixButton!.suffixButton,
                  )
                : null);

    return TextFormField(
        focusNode: focusNode,
        validator: (p0) => widget.validator?.call(p0 ?? ''),
        inputFormatters: widget.inputFormatters,
        onEditingComplete: widget.onEditingCompleted,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: widget.maxLength,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        textAlign: widget.textAlign,
        autofillHints: widget.autoFillType,
        enabled: widget.enabled,
        onTapOutside:
            widget.automaticUnfocus ? (_) => focusNode.unfocus() : null,
        controller: widget.textController,
        decoration: inputDecoration,
        textInputAction: widget.inputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.isPassword && !textVisible,
        enableSuggestions: !widget.isPassword,
        autocorrect: !widget.isPassword,
        onChanged: widget.onChanged,
        keyboardType: widget.textInputType,
        style: const TextStyle(height: 1));
  }
}

class BotonDerecho {
  final IconData icono;
  final double iconSize;
  final Function()? suffixButton;
  BotonDerecho({
    this.iconSize = 20,
    required this.icono,
    required this.suffixButton,
  });
}
