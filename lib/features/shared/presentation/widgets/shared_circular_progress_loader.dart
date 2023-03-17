import 'package:flutter/material.dart';

import '../../../../core/utils/theme.dart';

class SharedCircularProgressLoader extends StatelessWidget {
  final bool showIcon;
  final double size;

  const SharedCircularProgressLoader({
    this.showIcon = true,
    this.size = 50,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size,
      child: Stack(
        children:   [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              strokeWidth: 2,
              color: kAppRed, //const Color(0xff8280F7),

            ),
          ),
          if(showIcon) ... {
            const Align(
                alignment: Alignment.center,
                child: Icon(Icons.favorite, color: kAppRed,)
            )
          }
        ],
      ),
    );
  }
}
