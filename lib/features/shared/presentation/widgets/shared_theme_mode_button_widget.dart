import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SharedThemeModeButtonWidget extends StatelessWidget {

  final double size;
  final Color? color;
  const SharedThemeModeButtonWidget({
    this.size = 20,
    this.color,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return IconButton(onPressed: () => _onButtonPressed(theme, context), icon: Icon( theme.brightness == Brightness.dark ? FeatherIcons.sun : FeatherIcons.moon, color: theme.colorScheme.onBackground, size: size,));

  }

  void _onButtonPressed(ThemeData theme, BuildContext context) {

    if(theme.brightness == Brightness.dark) {
      AdaptiveTheme.of(context).setLight();
    }else {
      AdaptiveTheme.of(context).setDark();
    }

  }
}
