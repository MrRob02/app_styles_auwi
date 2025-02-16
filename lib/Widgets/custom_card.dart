import 'package:auwi_styles/auwi_styles.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final double elevation;
  final Color? color;
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function()? onLongPress;
  final EdgeInsets? padding;
  final bool notification;
  const CustomCard(
      {super.key,
      required this.child,
      this.color,
      this.notification = false,
      this.elevation = 0,
      this.borderRadius,
      this.onTap,
      this.onDoubleTap,
      this.padding,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final clr = color ?? Colors.white;
    return Stack(
      children: [
        Card(
            color: clr,
            surfaceTintColor: clr,
            clipBehavior: Clip.antiAlias,
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10)),
            child: InkWell(
              onTap: onTap,
              onDoubleTap: onDoubleTap,
              onLongPress: onLongPress,
              child: Padding(
                padding: padding ?? const EdgeInsets.all(10),
                child: child,
              ),
            )),
        if (notification)
          Positioned(
              left: 5,
              top: 5,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colores.colorPrimarioDark),
              )),
      ],
    );
  }
}
