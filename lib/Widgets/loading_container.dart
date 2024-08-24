import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final bool shortWidth;
  const LoadingContainer({super.key, this.shortWidth = false});

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 8,
      width: shortWidth ? sizeWidth / 2 : sizeWidth,
      color: Colors.grey.shade400,
    );
  }
}
