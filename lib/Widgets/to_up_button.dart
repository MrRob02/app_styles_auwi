import 'package:flutter/material.dart';

class ToUpButton extends FloatingActionButton {
  final ScrollController controller;
  ToUpButton({super.key, required this.controller})
      : super(onPressed: () => controller.jumpTo(0));

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onPressed,
      child: const Icon(Icons.arrow_upward),
    );
  }
}
