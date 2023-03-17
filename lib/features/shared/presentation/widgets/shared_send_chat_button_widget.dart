import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';

class SharedSendChatButtonWidget extends StatelessWidget {

  final Function()? onTap;

  const SharedSendChatButtonWidget({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: kAppBlue,
            borderRadius: BorderRadius.circular(100)
        ),
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(5),
        child: const Icon(FeatherIcons.send, color: kAppWhite, size: 15,),
      ),
    );

  }

}
