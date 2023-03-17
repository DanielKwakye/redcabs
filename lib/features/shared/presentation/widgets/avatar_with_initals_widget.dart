import 'package:flutter/material.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';

class AvatarWithInitialsWidget extends StatelessWidget {

  final String name;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool onlyFirstLetter;

  const AvatarWithInitialsWidget({
    Key? key,
    required this.name, this.backgroundColor, this.foregroundColor:Colors.white,
    this.onlyFirstLetter = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? accent.withOpacity(0.5),
      child: Text(onlyFirstLetter ? getFirstLetter(name): getInitials(name), style: TextStyle(color: foregroundColor ),),
    );
  }

}
