import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/mixins/form_mixin.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import '../../../../core/lang/lang.al.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/shared_button_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';
import '../../data/store/auth_cubit.dart';
import '../../data/store/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  SignupPageController createState() => SignupPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _SignupPageView extends WidgetView<SignupPage, SignupPageController> {
  const _SignupPageView(SignupPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SharedSliverAppBar(pageTitle: Strings.signup.get()),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(kAppLogo),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Welcome to Redcabs!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
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
                                      onSaved: (value) =>
                                          state.firstName = value!,
                                      inputType: TextInputType.text,
                                      validator: state.required,
                                      placeHolder: 'eg. John',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: SharedTextFieldWidget(
                                      label: 'Last name',
                                      onSaved: (value) =>
                                          state.otherNames = value!,
                                      validator: state.required,
                                      inputType: TextInputType.text,
                                      placeHolder: 'eg. Doe',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Phone number',
                                onSaved: (value) => state.phone = value!,
                                validator: state.required,
                                inputType: TextInputType.text,
                                placeHolder: '+31...',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Email',
                                onSaved: (value) => state.email = value!,
                                validator: state.required,
                                inputType: TextInputType.emailAddress,
                                placeHolder: 'yourname@example.com',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Password',
                                validator: state.required,
                                onSaved: (value) => state.password = value!,
                                isPassword: true,
                                placeHolder: 'Enter your password here',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SharedTextFieldWidget(
                                label: 'Confirm Password',
                                onSaved: (value) =>
                                    state.confirmPassword = value!,
                                isPassword: true,
                                validator: state.required,
                                placeHolder: 'Enter your password here',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              BlocBuilder<AuthCubit, AuthState>(
                                  bloc: state._authCubit,
                                  builder: (ctx, authState) {
                                    return SharedButtonWidget(
                                      text: 'Get started',
                                      loading: authState.status == BlocStatus.checkDriverExistProgress || authState.status == BlocStatus.verificationInProgress,
                                      expand: true,
                                      icon: const SizedBox(
                                          width: 15,
                                          child: Icon(Icons.person,
                                              size: 18, color: kAppWhite)),
                                      appearance: Appearance.primary,
                                      onPressed: () {
                                        state.signUpDriver(ctx);
                                      },
                                    );
                                  }),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(logInPageRoute);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RichText(
                            text: TextSpan(
                              text: '${Strings.alreadyHaveAccountQ.get()} ',
                              style:
                                  TextStyle(color: theme.colorScheme.onPrimary),
                              children: <TextSpan>[
                                TextSpan(
                                    text: Strings.login.get(),
                                    style: const TextStyle(color: kAppBlue)),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // const Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 20),
                      //   child:  CustomTermsPrivacyWidget(),
                      // ),

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

class SignupPageController extends State<SignupPage> with FormMixin {
  String? firstName;
  String? otherNames;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;

  @override
  Widget build(BuildContext context) => _SignupPageView(this);

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    listener = _authCubit.stream.listen((event) async {
      if (event.status == BlocStatus.checkDriverExistSuccess) {
        // when authentication is successful
        _sendVerificationCode();
      }
      if (event.status == BlocStatus.checkDriverExistFailure) {
        // when signup email checks is fails
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.verificationSuccess) {
        // when signup email checks is fails
        context.push(Uri(path: verifyOtpPageRoute, queryParameters: {
          'firstName': firstName,
          'otherNames': otherNames,
          'phone': phone,
          'email': email,
          'password': password,
          'token':event.message
        }).toString());
      }
    });
   }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  Future<void> _sendVerificationCode() async {
    _authCubit.sendVerificationCode(phone: phone!);
  }

  signUpDriver(BuildContext ctx) {
    if (!validateAndSaveOnSubmit(ctx)) {
      return;
    }

    if (blank(password) || blank(confirmPassword)) {
      showHandyAlertDialog(context, content: "Please enter your password");
      return;
    }

    if (password != confirmPassword) {
      showHandyAlertDialog(context,
          content: "Password does not match confirmed password");
      return;
    }
    if (kDebugMode) {
      print('check driver');
    }
    _authCubit.checkIfDriverExist(email: email!, phone: phone!);
  }
}
