import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/extensions.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_network_image_widget.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/theme.dart';

class SharedAvatarWidget extends StatelessWidget {

  final double size;
  final Color? color;
  final String? imageUrl;
  final bool online;
  final bool showBorder;
  final double borderSize;

  const SharedAvatarWidget({
    this.size = 35,
    this.color,
    this.imageUrl,
    this.showBorder = true,
    this.online = false,
    this.borderSize = 2.0,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(
          border: showBorder ? Border.all(color: online ? kAppGreen : color ?? theme.colorScheme.onBackground, width: borderSize) : null,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: imageUrl.isNullOrEmpty() ? Image.asset(kAvatarPlaceholder, width: size,) :
        SizedBox(
            width: size,
            height: size,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: SharedNetworkImageWidget(imageUrl: imageUrl ?? '', fit: BoxFit.fitHeight,)))
    );
  }
}
