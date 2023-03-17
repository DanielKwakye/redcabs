import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {

  final Widget child;
  final double padding;
  final double paddingLeft;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  const CustomCardWidget({ Key? key, required this.child, this.padding = 20,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingBottom = 0,
    this.paddingTop = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
          padding: padding == 0 ? EdgeInsets.only(left: paddingLeft, top: paddingTop, right: paddingRight, bottom: paddingBottom) : EdgeInsets.all(padding),
          child: child,
      ),
    );
  }
}
