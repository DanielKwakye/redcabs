import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/features/home/presentation/widgets/shared_logout_button_widget.dart';

import '../../../../app/routing/route_constants.dart';
import '../../../shared/presentation/widgets/shared_avatar_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../../shared/presentation/widgets/shared_theme_changer_button_widget.dart';
import '../../../notifications/presentation/widgets/notification_icon_button_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppStorage.currentUserSession;
    // if (kDebugMode) {
    //   print('${user?.toJson()}-------------user');
    // }

    return SharedSliverAppBar(
      leading: GestureDetector(
        onTap: (){
          context.push(settingsPageRoute);
        },
        child: const UnconstrainedBox(
          child:  SharedAvatarWidget( showBorder: false, size: 30,),
        ),
      ),
      pinned: true,
      backgroundColor: kAppRed,
      pageTitleColor: kAppWhite,
      centerTitle: false,
      pageTitle: '${user?.name} ${user?.otherNames??''}',
      actions:  const [
        SharedThemeChangerButtonWidget(
          color: kAppWhite,
        ),
        NotificationIconButtonWidget()
      ],

    );
  }
}
