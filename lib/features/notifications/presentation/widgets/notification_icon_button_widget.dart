import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/notifications/data/store/notification_state.dart';
import '../../../../app/routing/route_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../data/store/notification_cubit.dart';
import 'package:badges/badges.dart' as badges;


class NotificationIconButtonWidget extends StatefulWidget {

  const NotificationIconButtonWidget({Key? key}) : super(key: key);

  @override
  NotificationIconButtonWidgetController createState() => NotificationIconButtonWidgetController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _NotificationButtonWidgetView extends WidgetView<NotificationIconButtonWidget, NotificationIconButtonWidgetController> {

  const _NotificationButtonWidgetView(NotificationIconButtonWidgetController state) : super(state);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (_, next) {
        return
          next.status == BlocStatus.fetchNotificationsCountSuccess
          || next.status == BlocStatus.markNotificationsAsReadSuccess;
      },
      builder: (context, notificationState) {

        if(notificationState.notificationsCount < 1) {
          return iconButton(context);
        }

        return  badges.Badge(
          position: badges.BadgePosition.topEnd(top: 7, end: 7),
          badgeContent: Text(notificationState.notificationsCount.toString(), style: TextStyle(color: kAppWhite, fontSize: 10, fontWeight: FontWeight.bold),),
          badgeStyle: const badges.BadgeStyle(
            badgeColor: kAppBlue,
          ),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            // colorChangeAnimationDuration: Duration(seconds: 1),
            // loopAnimation: false,false
            curve: Curves.easeInCubic,
            // colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          child: iconButton(context),
        );
      },
    );

  }

  Widget iconButton(BuildContext context) {
    return IconButton(onPressed: (){
        context.push(notificationsPageRoute);
      }, icon:  const Icon(FeatherIcons.bell, size: 20,
        // color: theme.colorScheme.onBackground,
        color: kAppWhite,
      ));
  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class NotificationIconButtonWidgetController extends State<NotificationIconButtonWidget> {

  late NotificationCubit notificationCubit;
  @override
  Widget build(BuildContext context) => _NotificationButtonWidgetView(this);

  @override
  void initState() {
    super.initState();
    notificationCubit = context.read<NotificationCubit>();
    notificationCubit.fetchNotificationCount();
  }


  @override
  void dispose() {
    super.dispose();
  }

}