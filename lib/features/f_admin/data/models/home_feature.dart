import 'package:flutter/cupertino.dart';

class HomeFeature {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final String? pageRoute;

  HomeFeature({required this.title,
    required this.icon,
    required this.backgroundColor,
    this.pageRoute
  });
}