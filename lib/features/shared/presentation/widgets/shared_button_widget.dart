import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';

class SharedButtonWidget extends StatelessWidget {

  final String text;
  final Function()? onPressed;
  final Appearance? appearance;
  final bool expand;
  final Widget? icon;
  final bool loading;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? outlineColor;
  final bool showOutline;
  final FontWeight? fontWeight;
  final double? fontSize;
  // final

  const SharedButtonWidget({
    required this.text,
    Key? key, this.onPressed,
    this.appearance = Appearance.primary,
    this.expand = false,
    this.icon,
    this.loading = false,
    this.textColor,
    this.backgroundColor,
    this.outlineColor,
    this.showOutline = true,
    this.fontWeight,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return SizedBox(
      width: expand ? MediaQuery.of(context).size.width : null,
      child: ElevatedButton.icon(
        icon: loading ? const SizedBox.shrink() : (icon ?? const SizedBox.shrink()),
        onPressed: loading ? null : (onPressed ?? (){}),
        label: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: expand ? 14 : 0),
          child: loading ?
          // Loading State
          CupertinoActivityIndicator(color: appearance == Appearance.clean ? theme.colorScheme.onBackground : kAppWhite,)

          // Normal state
              : Text(text,
            textAlign: TextAlign.justify,
            style: TextStyle(color:  textColor ?? (onPressed == null ? theme.colorScheme.onPrimary :
            appearance == Appearance.clean ? theme.colorScheme.onBackground :
            appearance == Appearance.secondary ? kAppWhite : kAppWhite
            ), fontWeight: fontWeight,fontSize: fontSize),
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular( expand ? 8 : 5),
                  side:  showOutline ? BorderSide(color: outlineColor ?? theme.colorScheme.outline, width: outlineColor != null ? 1 : 0) : BorderSide.none
              )
          ),
          backgroundColor: backgroundColor != null ?
          MaterialStateProperty.resolveWith<Color>((states) => backgroundColor!)
              : MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                // appearance when button is pressed
                switch (appearance){
                  case Appearance.primary:
                    return kAppFaintBlack;
                  case Appearance.secondary:
                    return kAppBlue;
                  case Appearance.clean:
                    return kAppBlue;
                  default:
                    return kAppFaintBlack;
                }

              }

              if(onPressed == null){
                return kAppFaintBlack;
              }

              // background color
              switch (appearance){
                case Appearance.primary:
                  return kAppRed;
                case Appearance.dark:
                  return kAppBlack;
                case Appearance.secondary:
                  return kAppBlue;
                case Appearance.success:
                  return kAppGreen;
                case Appearance.clean:
                  return Colors.transparent;
                default:
                  return kAppRed;
              }

            },
          ),
        ),
      ),
    );
  }
}
