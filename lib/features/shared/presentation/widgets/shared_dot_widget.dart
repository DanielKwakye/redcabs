import 'package:flutter/material.dart';

class SharedDotWidget extends StatelessWidget {

  final Color? color;
  final double horizontalPadding;
  const SharedDotWidget({
    this.color,
    this.horizontalPadding = 5,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 3, height: 3,
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color ?? theme.colorScheme.onPrimary
      ),
    );
  }
}
