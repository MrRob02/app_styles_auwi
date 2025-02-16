import 'package:auwi_styles/Herramientas/colores.dart';
import 'package:flutter/material.dart';

enum EnumIconSize {
  small,
  original,
  medium,
  big,
  giant;

  double get value {
    switch (this) {
      case small:
        return 16;
      case original:
        return 24;
      case medium:
        return 32;
      case big:
        return 48;
      case giant:
        return 64;
    }
  }
}

class CustomIcon extends Icon {
  final EnumIconSize _size;
  final Function()? onPressed;
  const CustomIcon.small(super.icon, {super.key, super.color})
      : _size = EnumIconSize.small,
        onPressed = null;
  const CustomIcon(super.icon, {super.key, super.color})
      : _size = EnumIconSize.original,
        onPressed = null;
  const CustomIcon.medium(super.icon, {super.key, super.color})
      : _size = EnumIconSize.medium,
        onPressed = null;
  const CustomIcon.big(super.icon, {super.key, super.color})
      : _size = EnumIconSize.big,
        onPressed = null;
  const CustomIcon.giant(super.icon, {super.key, super.color})
      : _size = EnumIconSize.giant,
        onPressed = null;
  const CustomIcon.button(super.icon, {super.key, super.color, this.onPressed})
      : _size = EnumIconSize.original;

  @override
  Widget build(BuildContext context) {
    var icon2 = Icon(
      icon,
      size: _size.value,
      color: color ?? Colores.grisPrimario,
    );
    if (onPressed == null) return icon2;
    return IconButton(
      padding: onPressed == null ? EdgeInsets.zero : null,
      icon: icon2,
      onPressed: onPressed,
    );
  }
}
