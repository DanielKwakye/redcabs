import 'package:flutter/material.dart';

class SharedBorderWidget extends StatelessWidget {
  final String? centerText;
  final Color? color;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  const SharedBorderWidget({
    this.color, this.centerText,
    this.paddingLeft = 0,
    this.paddingRight = 0,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding:  EdgeInsets.only(left: paddingLeft, right: paddingRight, top: paddingTop, bottom: paddingBottom),
      child: Row(
        children: [
          Expanded(child: Container(
            color: color ?? theme.colorScheme.outline,
            height: 1,
          )),
          if(centerText != null) ...{
            Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(centerText!, style: TextStyle(color: color ?? theme.colorScheme.onPrimary),),
            )
          },
          Expanded(child: Container(
            color: color ?? Theme.of(context).colorScheme.outline,
            height: 1,
          ))
        ],
      ),
    );
  }
}
