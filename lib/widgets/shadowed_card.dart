import 'package:flutter/material.dart';
import 'package:untitled_design/styles/styles.dart';

class ShadowedCard extends StatelessWidget {
  const ShadowedCard({
    required this.child,
    this.radius,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: CustomColors.backgroundColor,
      shadowColor: CustomColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
      child: child,
    );
  }
}
