import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:redcabs_mobile/core/mixins/form_mixin.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';

import '../../../../core/lang/lang.al.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../auth/data/store/auth_cubit.dart';
import '../../../auth/data/store/auth_state.dart';
import '../../../shared/presentation/widgets/shared_button_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';

class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  ChangePasswordPageController createState() => ChangePasswordPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _ChangePasswordPageView extends WidgetView<ChangePasswordPage, ChangePasswordPageController> {

  const _ChangePasswordPageView(ChangePasswordPageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SharedSliverAppBar(pageTitle: Strings.updatePassword.get()),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.asset(kAppLogo),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Update Your Password',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimationConfiguration.synchronized(
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 800),
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SharedTextFieldWidget(
                                    label: 'Current Password',
                                    isPassword: true,
                                    validator: state.required,
                                    placeHolder: 'Enter your current password',
                                    controller: state.currentPasswordController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SharedTextFieldWidget(
                                    label: 'New Password',
                                    isPassword: true,
                                    validator: state.required,
                                    placeHolder: 'Enter your new password',
                                    controller: state.newPasswordController,
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SharedTextFieldWidget(
                                    label: 'Confirm New Password',
                                    isPassword: true,
                                    validator: state.required,
                                    placeHolder: 'Confirm your new password',
                                    controller: state.confirmNewPasswordController,
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    bloc: state._authCubit,
                                    builder: (ctx, authState) {
                                      return SharedButtonWidget(
                                        loading:
                                        authState.status == BlocStatus.loading,
                                        text: Strings.update.get(),
                                        expand: true,
                                        icon: const SizedBox(
                                            width: 15,
                                            child: Icon(Icons.person,
                                                size: 18, color: kAppWhite)),
                                        appearance: Appearance.primary,
                                        onPressed: () {
                                          state.updateDriverPassword(ctx);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: kToolbarHeight,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class ChangePasswordPageController extends State<ChangePasswordPage>  with FormMixin{
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) => _ChangePasswordPageView(this);

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    listener = _authCubit.stream.listen((event) async {
      if (event.status == BlocStatus.success) {
        // when profile has been saved
        showSnackBar(context, event.message, appearance: Appearance.success);
        Navigator.pop(context);
      }
      if (event.status == BlocStatus.error) {
        // when authentication is fails
        showSnackBar(context, event.message, appearance: Appearance.error);
      }
    });

  }


  @override
  void dispose() {
    super.dispose();
    listener.cancel();

  }

  updateDriverPassword(BuildContext ctx) {
    if (!validateAndSaveOnSubmit(ctx)) {
      return;
    }

    if(newPasswordController.text != confirmNewPasswordController.text){
      showSnackBar(context, "New Passwords do not match", appearance: Appearance.error);
      return;
    }

    _authCubit.updateDriverPassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );
  }


}