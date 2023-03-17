import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';


class SharedThemeChangerButtonWidget extends StatefulWidget {

  final Color? color;
  const SharedThemeChangerButtonWidget({
    this.color,
    Key? key}) : super(key: key);

  @override
  SharedThemeChangerButtonWidgetController createState() => SharedThemeChangerButtonWidgetController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _SharedThemeChangerButtonWidgetView extends WidgetView<SharedThemeChangerButtonWidget, SharedThemeChangerButtonWidgetController> {

  const _SharedThemeChangerButtonWidgetView(SharedThemeChangerButtonWidgetController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);
    final adaptiveThemeMode = AdaptiveTheme.of(context);

    return IconButton(onPressed: (){
      if(theme.brightness == Brightness.light) {
        adaptiveThemeMode.setDark();
      }else {
        adaptiveThemeMode.setLight();
      }
    }, icon: Icon(theme.brightness == Brightness.light ? FeatherIcons.sun : FeatherIcons.moon, size: 20, color: widget.color ?? theme.colorScheme.onBackground,));

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class SharedThemeChangerButtonWidgetController extends State<SharedThemeChangerButtonWidget> {


  @override
  Widget build(BuildContext context) => _SharedThemeChangerButtonWidgetView(this);

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }

}