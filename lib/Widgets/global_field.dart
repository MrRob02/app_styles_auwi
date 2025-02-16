import 'package:auwi_styles/auwi_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum EnumTipoField { text, number, email, password, otp }

class GlobalField extends StatefulWidget {
  ///El primero es si es password y el segundo es si esta visible la contra
  final bool isPassword;
  final TextEditingController? controller;
  final String hint;
  final String? downMessage;
  final TextAlign textAlign;
  final EnumTipoField _tipo;
  final int? maxLength;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFinish;
  final TextInputAction? inputAction;
  final TextInputFormatter? inputFormatter;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool showCounter;
  final Widget? suffixButton;
  final Function(String)? onFieldSubmitted;
  const GlobalField(
      {super.key,
      required this.hint,
      this.controller,
      this.downMessage,
      this.validator,
      this.textAlign = TextAlign.start,
      this.onChanged,
      this.maxLength,
      this.inputAction,
      this.maxLines,
      this.focusNode,
      this.showCounter = false,
      this.suffixButton,
      this.onFieldSubmitted})
      : isPassword = false,
        _tipo = EnumTipoField.text,
        onFinish = null,
        inputFormatter = null;

  const GlobalField.email(
      {super.key,
      required this.hint,
      this.controller,
      this.downMessage,
      this.validator,
      this.onChanged,
      this.inputAction,
      this.focusNode,
      this.suffixButton,
      this.onFieldSubmitted})
      : isPassword = false,
        maxLines = 1,
        showCounter = false,
        inputFormatter = null,
        textAlign = TextAlign.start,
        _tipo = EnumTipoField.email,
        maxLength = 100,
        onFinish = null;

  const GlobalField.password(
      {super.key,
      required this.hint,
      this.controller,
      this.downMessage,
      this.validator,
      this.maxLength,
      this.onChanged,
      this.maxLines = 1,
      this.inputAction,
      this.focusNode,
      this.onFieldSubmitted})
      : suffixButton = null,
        isPassword = true,
        showCounter = false,
        textAlign = TextAlign.start,
        _tipo = EnumTipoField.password,
        inputFormatter = null,
        onFinish = null;

  GlobalField.number(
      {super.key,
      required this.hint,
      this.controller,
      this.downMessage,
      this.validator,
      this.onChanged,
      this.inputAction,
      this.maxLines,
      this.focusNode,
      this.suffixButton,
      this.onFieldSubmitted})
      : isPassword = false,
        textAlign = TextAlign.start,
        _tipo = EnumTipoField.number,
        maxLength = 7,
        inputFormatter = Styles.onlyDecimals,
        showCounter = false,
        onFinish = null;
  GlobalField.otp(
      {super.key,
      this.controller,
      required this.onFinish,
      this.onChanged,
      this.focusNode,
      this.onFieldSubmitted})
      : suffixButton = null,
        showCounter = true,
        isPassword = false,
        downMessage = null,
        validator = null,
        maxLines = 1,
        inputFormatter = FilteringTextInputFormatter.digitsOnly,
        hint = List.generate(6, (_) => '0').join(' '),
        textAlign = TextAlign.center,
        _tipo = EnumTipoField.otp,
        maxLength = 6,
        inputAction = TextInputAction.done;

  @override
  State<GlobalField> createState() => _GlobalFieldState();
}

class _GlobalFieldState extends State<GlobalField> {
  late TextEditingController controller;
  bool obscureText = true;
  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscureText : false,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        enableSuggestions: false,
        validator: widget.validator,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        buildCounter: (context,
                {required currentLength,
                required isFocused,
                required maxLength}) =>
            null,
        focusNode: widget.focusNode,
        autofillHints: autoFillHints,
        onChanged: widget.onChanged,
        style: isOtp ? const TextStyle(fontSize: 20, letterSpacing: 25) : null,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        keyboardType: inputType,
        decoration: InputDecoration(
          suffixIcon: suffix,
          fillColor: Colores.colorBackgroundDark,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colores.colorPrimarioDark)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          hintText: widget.hint,
          hintStyle:
              isOtp ? const TextStyle(fontSize: 20, letterSpacing: 15) : null,
        ));
  }

  bool get isOtp => widget._tipo == EnumTipoField.otp;
  Widget? get suffix => widget.isPassword
      ? IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          })
      : widget.suffixButton;
  TextInputType get inputType {
    switch (widget._tipo) {
      case EnumTipoField.text:
        return TextInputType.text;
      case EnumTipoField.email:
        return TextInputType.emailAddress;
      case EnumTipoField.password:
        return TextInputType.visiblePassword;
      case EnumTipoField.otp:
      case EnumTipoField.number:
        return TextInputType.number;
    }
  }

  get autoFillHints {
    switch (widget._tipo) {
      case EnumTipoField.text:
      case EnumTipoField.number:
        return null;
      case EnumTipoField.email:
        return [AutofillHints.email];
      case EnumTipoField.password:
        return [AutofillHints.password];
      case EnumTipoField.otp:
        return [AutofillHints.oneTimeCode];
    }
  }
}
