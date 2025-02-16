import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:flutter/material.dart';

enum EnumMaterialText { huge, title, subtitle, body, caption, error }

class CustomText extends StatefulWidget {
  final String text;
  final TextAlign? textAlign;
  final EnumMaterialText type;
  final bool? isBold;
  final bool? isFlexible;
  final Color? color;
  final TextOverflow? textOverflow;
  final int? maxLines;
  const CustomText(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible,
      this.maxLines})
      : type = EnumMaterialText.body;
  const CustomText.huge(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible,
      this.maxLines})
      : type = EnumMaterialText.huge;
  const CustomText.title(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible,
      this.maxLines})
      : type = EnumMaterialText.title;
  const CustomText.subtitle(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible,
      this.maxLines})
      : type = EnumMaterialText.subtitle;
  const CustomText.caption(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible,
      this.maxLines})
      : type = EnumMaterialText.caption;
  const CustomText.error(this.text,
      {super.key,
      this.textAlign,
      this.isBold,
      this.color,
      this.textOverflow,
      this.isFlexible})
      : type = EnumMaterialText.error,
        maxLines = null;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      overflow: widget.textOverflow,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: style,
    );
    return widget.isFlexible == true
        ? Flexible(
            fit: FlexFit.loose,
            child: textWidget,
          )
        : textWidget;
  }

  TextStyle get style {
    final fontWeight = widget.isBold == null
        ? null
        : widget.isBold!
            ? FontWeight.bold
            : FontWeight.normal;
    switch (widget.type) {
      case EnumMaterialText.huge:
        return const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colores.textos)
            .copyWith(fontWeight: fontWeight, color: widget.color);
      case EnumMaterialText.title:
        return const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colores.textos)
            .copyWith(fontWeight: fontWeight, color: widget.color);
      case EnumMaterialText.subtitle:
        return const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colores.textos)
            .copyWith(fontWeight: fontWeight, color: widget.color);
      case EnumMaterialText.body:
        return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colores.textos)
            .copyWith(fontWeight: fontWeight, color: widget.color);
      case EnumMaterialText.error:
        return const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colores.errorColor)
            .copyWith(fontWeight: fontWeight, color: widget.color);
      case EnumMaterialText.caption:
        return const TextStyle(
                fontSize: 8, fontWeight: FontWeight.w400, color: Colores.textos)
            .copyWith(fontWeight: fontWeight, color: widget.color);
    }
  }
}
