import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/notifications/data/data/models/notification_model.dart';
import 'package:redcabs_mobile/features/notifications/data/store/notification_cubit.dart';
import 'package:redcabs_mobile/features/notifications/data/store/notification_state.dart';
import 'package:redcabs_mobile/features/notifications/presentation/widgets/notification_item_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_circular_loader.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_error_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';

class NotificationsHomePage extends StatefulWidget {

  const NotificationsHomePage({Key? key}) : super(key: key);

  @override
  NotificationsHomePageController createState() => NotificationsHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _NotificationsHomePageView extends WidgetView<NotificationsHomePage, NotificationsHomePageController> {

  const _NotificationsHomePageView(NotificationsHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        body: NestedScrollView(headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SharedSliverAppBar(
              pageTitle: innerBoxIsScrolled ? 'Inbox' : '',
              // backgroundColor: kAppRed,
              // pageTitleColor: kAppWhite,
              // centerTitle: false,
              // iconThemeColor: kAppWhite,
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 0),
                child: Text(
                  'Inbox',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding:  const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Notifications',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SharedBorderWidget(paddingTop: 5,)
                  ],
                ),
              ),
            )
          ];
        }, body: BlocBuilder<NotificationCubit, NotificationState>(
          bloc: state.notificationCubit,
          buildWhen: (_, next) {
            return
              next.status == BlocStatus.fetchNotificationsSuccess
              || next.status == BlocStatus.fetchNotificationsInProgress
              || next.status == BlocStatus.fetchNotificationsError;
          },
          builder: (context, notificationState) {

            if(notificationState.status == BlocStatus.fetchNotificationsInProgress) {
              return const SharedCircularLoader();
            }

            if(notificationState.status == BlocStatus.fetchNotificationsError) {
              return const SharedErrorWidget();
            }

            if (notificationState.status == BlocStatus.fetchNotificationsSuccess) {

              if(notificationState.notifications.isEmpty) {
                return  Center(
                  child: Text('No notifications found ...',style: themeOf(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),),
                );
              }

              return ListView.separated(itemBuilder: (ctx, i) {
                final notificationModel = notificationState.notifications[i];
                return GestureDetector(
                  onTap: () {
                    state.onNotificationTapped(notificationModel);
                  },
                  child: NotificationItemWidget(
                    notificationModel: notificationModel,),
                );
              },
                separatorBuilder: (ctx, i) {
                  return const SizedBox(height: 20,);
                },
                itemCount: notificationState.notifications.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 15),);
            }

            return const SizedBox.shrink();

          }


          ),

        )
    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class NotificationsHomePageController extends State<NotificationsHomePage> {

  late NotificationCubit notificationCubit;

  @override
  Widget build(BuildContext context) => _NotificationsHomePageView(this);

  @override
  void initState() {
    super.initState();
    
    notificationCubit = context.read<NotificationCubit>();
    initialize();
    
  }

  void initialize() async {
    await notificationCubit.fetchNotificationList();
    notificationCubit.markNotificationsAsRead();
  }

  void onNotificationTapped(NotificationModel notification) async {
    {
      if (notification.messageType == 'support') {
        context.push(chatPageRoute);
      } else if (notification.messageType == 'receipt') {
        context.push(chatPageRoute);
      }else if (notification.messageType == 'payout') {
        context.push(chatPageRoute);
      }
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

}