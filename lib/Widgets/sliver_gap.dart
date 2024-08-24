import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SliverGap extends StatelessWidget {
  final double gap;
  const SliverGap({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Gap(gap));
  }
}
