import 'package:flutter/material.dart';

import '../../../../core/utils/theme.dart';

class SharedCircularLoader extends StatelessWidget {
  final double size;
  const SharedCircularLoader({Key? key, this.size = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(width: size,
          height: size,
          child: const CircularProgressIndicator(color: kAppBlue, strokeWidth: 2,),),
      ),
    );

  }
}
