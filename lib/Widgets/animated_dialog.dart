import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeroDialog extends StatelessWidget {
  final String tag;
  final Widget? positionedChild;
  final Widget? centerChild;
  final List<Widget> children;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const HeroDialog(
      {super.key,
      required this.tag,
      this.centerChild,
      this.positionedChild,
      this.top,
      this.bottom,
      this.right,
      this.left,
      this.children = const []});

  @override
  Widget build(BuildContext context) {
    if (positionedChild != null && centerChild != null ||
        positionedChild == null && centerChild == null) {
      throw Exception(
          'centerChild or positionedChild must be provided, not both');
    }
    return GestureDetector(
      onTap: Get.back,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.9),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: positionedChild != null
                ? Stack(
                    children: [
                      Positioned(
                        child: heroWidget(positionedChild!),
                      ),
                      ...children
                    ],
                  )
                : Center(child: heroWidget(centerChild!)),
          ),
        ),
      ),
    );
  }

  Widget heroWidget(Widget child) {
    return GestureDetector(
      child: Material(
          color: Colors.transparent, child: Hero(tag: tag, child: child)),
      onTap: () {},
    );
  }
}
