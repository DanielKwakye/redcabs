import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/utils/enums.dart';

class AnimatedColumnWidget extends StatelessWidget {

  final List<Widget> children;
  final AnimateType animateType;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  const AnimatedColumnWidget({super.key, required this.children, this.animateType= AnimateType.slideLeft,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max
  });

  @override
  Widget build(BuildContext context) {
    if(animateType == AnimateType.slideUp){
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 50.0,
              child: SlideAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
    }else{
      return AnimationLimiter(
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 500),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: children,
          ),
        ),
      );
    }

  }
}
