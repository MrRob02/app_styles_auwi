import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? elevation;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  const CustomCard(
      {super.key,
      required this.child,
      this.color,
      this.elevation,
      this.borderRadius,
      this.onTap,
      this.onDoubleTap,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final clr = color ?? Colors.white;
    return Card(
        color: clr,
        surfaceTintColor: clr,
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        child: InkWell(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          child: child,
        ));
  }
}
