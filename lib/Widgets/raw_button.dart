import 'package:flutter/material.dart';

class RawButton extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final ShapeBorder? shape;
  const RawButton(
      {super.key, required this.child, required this.onTap, this.shape});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
