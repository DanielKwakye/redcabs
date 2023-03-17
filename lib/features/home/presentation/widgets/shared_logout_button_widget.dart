import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';
import '../../../auth/data/store/auth_cubit.dart';
import '../../../auth/data/store/auth_state.dart';

class SharedLogoutButtonWidget extends StatefulWidget {

  final Color? color;
  const SharedLogoutButtonWidget({
    this.color,
    Key? key}) : super(key: key);

  @override
  SharedLogoutButtonWidgetController createState() => SharedLogoutButtonWidgetController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _SharedLogoutButtonWidgetView extends WidgetView<SharedLogoutButtonWidget, SharedLogoutButtonWidgetController> {

  const _SharedLogoutButtonWidgetView(SharedLogoutButtonWidgetController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);
    return ListTile(
      onTap: () {
        state.logoutTapped();
      },
      leading: const CircleAvatar(
        backgroundColor: ash,
        child: Icon(
          Icons.logout,
          size: 20,
          color: kAppWhite,
        ),
      ),
      title: const Text(
        "Logout",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 17,
      ),
    );
    // return IconButton(onPressed: , icon: Icon(FeatherIcons.logOut, size: 20, color: widget.color ?? theme.colorScheme.onBackground,));

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class SharedLogoutButtonWidgetController extends State<SharedLogoutButtonWidget> {

  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;

  @override
  Widget build(BuildContext context) => _SharedLogoutButtonWidgetView(this);

  @override
  void initState() {
    super.initState();

    _authCubit  = AuthCubit();

    listener  = _authCubit.stream.listen((event) {
      if(event.status == BlocStatus.logOutUser) {
       context.go(landingPageRoute);
      }
    });

  }

  void logoutTapped() {
    showDecisionDialog(context,
      title: "Do you want to logout?",
      subtitle: "You'd have to login again next time you open the app",
      confirmActionText: 'Yes, logout',
      onConfirmTapped: () {
        _authCubit.logout();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

}