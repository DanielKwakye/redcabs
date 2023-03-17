import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double topSafeArea;
  @override
  final double maxExtent;

  PersistentHeader({
    required this.child,
    this.maxExtent = 350,
    this.topSafeArea = 0,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    final appBarSize = maxExtent - shrinkOffset;
    // final proportion = 2 - (maxExtent / appBarSize);
    return Theme(
      data: ThemeData.dark(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: maxExtent),
        child: child,
      ),
    );
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  double get minExtent => kToolbarHeight + topSafeArea;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}