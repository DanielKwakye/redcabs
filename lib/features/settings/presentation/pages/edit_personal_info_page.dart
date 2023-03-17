import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/core/mixins/form_mixin.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/users/data/models/user_model.dart';

import '../../../../app/routing/route_constants.dart';
import '../../../../core/lang/lang.al.dart';
import '../../../../core/storage/app_storage.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../auth/data/store/auth_cubit.dart';
import '../../../auth/data/store/auth_state.dart';
import '../../../shared/presentation/widgets/shared_button_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileController createState() => EditProfileController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _EditProfileView extends WidgetView<EditProfile, EditProfileController> {
  const _EditProfileView(EditProfileController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SharedSliverAppBar(pageTitle: 'Account ${Strings.profile.get()}'),
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
                  'Edit Personal Profile',
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
                              Row(
                                children: [
                                  Expanded(
                                    child: SharedTextFieldWidget(
                                      label: 'First name',
                                      onSaved: (value) {},
                                      inputType: TextInputType.text,
                                      validator: state.required,
                                      placeHolder: 'eg. John',
                                      controller: state.firstNameController,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SharedTextFieldWidget(
                                      label: 'Last name',
                                      onSaved: (value) {},
                                      validator: state.required,
                                      inputType: TextInputType.text,
                                      placeHolder: 'eg. Doe',
                                      controller: state.lastNameController,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Phone number',
                                onSaved: (value) {},
                                validator: state.required,
                                inputType: TextInputType.text,
                                placeHolder: '+31...',
                                controller: state.phoneController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Email',
                                onSaved: (value) {},
                                validator: state.required,
                                inputType: TextInputType.emailAddress,
                                placeHolder: 'yourname@example.com',
                                controller: state.emailController,
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
                                      state.updateDriverInfo(ctx);
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

class EditProfileController extends State<EditProfile> with FormMixin {
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final UserModel? user = AppStorage.currentUserSession;

  @override
  Widget build(BuildContext context) => _EditProfileView(this);

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    firstNameController.text = user?.name ?? '';
    lastNameController.text = user?.otherNames ?? '';
    phoneController.text = user?.phone ?? '';
    emailController.text = user?.email ?? '';
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

  updateDriverInfo(BuildContext ctx) {
    if (!validateAndSaveOnSubmit(ctx)) {
      return;
    }
    _authCubit.updateDriverInfo(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneController.text,
      email: emailController.text,
    );
  }
}
