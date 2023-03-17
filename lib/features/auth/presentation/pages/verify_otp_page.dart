import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/mixins/form_mixin.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_circular_progress_loader.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_sliver_app_bar.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/shared_button_widget.dart';
import '../../../shared/presentation/widgets/shared_text_field_widget.dart';
import '../../data/store/auth_cubit.dart';
import '../../data/store/auth_state.dart';

class VerifyOtpPage extends StatefulWidget {
  final String firstName;
  final String otherNames;
  final String phone;
  final String email;
  final String password;
  final String token;

  const VerifyOtpPage(
      {Key? key,
      required this.firstName,
      required this.otherNames,
      required this.phone,
      required this.email,
      required this.password, required this.token})
      : super(key: key);

  @override
  VerifyOtpPageController createState() => VerifyOtpPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _VerifyOtpPageView
    extends WidgetView<VerifyOtpPage, VerifyOtpPageController> {
  const _VerifyOtpPageView(VerifyOtpPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SharedSliverAppBar(pageTitle: ""),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  // const CustomDefaultLogoWidget(),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Enter code to continue",
                      style: style,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Column(
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Thanks for choosing ",
                          style: TextStyle(
                              color: theme.colorScheme.onBackground,
                              fontSize: 14),
                          children: const <TextSpan>[
                            TextSpan(
                              text: "Redcabs",
                              style: TextStyle(color: kAppRed, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      child: AnimationConfiguration.synchronized(
                          child: SlideAnimation(
                              duration: const Duration(milliseconds: 800),
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Column(children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Please check your email (${state.email}) for a code we sent. Didn’t receive it? Click resend email below",
                                    style: TextStyle(
                                        color: theme.colorScheme.onSurface,
                                        height: 1.5),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  SharedTextFieldWidget(
                                    validator: state.required,
                                    label: 'Verification code',
                                    placeHolder: 'Enter verification code here',
                                    onSaved: (value) => state.code = value!,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    bloc: state._authCubit,
                                    builder: (ctx, authState) {
                                      return SharedButtonWidget(
                                        loading: authState.status ==
                                            BlocStatus.otpVerificationInProgress,
                                        text: 'Verify',
                                        expand: true,
                                        appearance: Appearance.primary,
                                        onPressed: () {
                                          state.verifyAuthCode(ctx);
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  BlocBuilder<AuthCubit, AuthState>(
                                      bloc: state._authCubit,
                                      builder: (ctx, authState) {

                                        if(authState.status == BlocStatus.resendVerificationInProgress) {
                                          return const SharedCircularProgressLoader(showIcon: false, size: 20,);
                                        }

                                        return GestureDetector(
                                          onTap: () {
                                            state._sendVerificationCode();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Didn\'t get the code? ',
                                                style: TextStyle(
                                                    color: theme
                                                        .colorScheme.onBackground),
                                                children: const <TextSpan>[
                                                  TextSpan(
                                                      text: 'Resend',
                                                      style:
                                                      TextStyle(color: kAppBlue)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                  }),

                                  const SizedBox(
                                    height: 40,
                                  ),
                                  // SharedTermsPrivacyWidget(textColor: theme.colorScheme.onSurface,),
                                ]),
                              ))),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class VerifyOtpPageController extends State<VerifyOtpPage> with FormMixin {
  late String email;
  late String code;
  late String token;
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;

  @override
  Widget build(BuildContext context) => _VerifyOtpPageView(this);

  @override
  void initState() {
    super.initState();
    email = widget.email;
    token = widget.token;
    _authCubit = context.read<AuthCubit>();
    listener = _authCubit.stream.listen((event) async {
      if (event.status == BlocStatus.otpVerificationInError) {
        // verification error,
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.otpVerificationInSuccessful) {
        // when authentication is successful, register driver
        _registerDriver();
      }

      if (event.status == BlocStatus.registrationSuccess) {
        // when registration is successful, login the user
        _authCubit.login(email: widget.email, password: widget.password);
      }

      if (event.status == BlocStatus.loginSuccessful) {
        // when login is successful, navigate user to home page
        showSnackBar(context, event.message);
        context.go(fAdminPageRoute);
      }

      if (event.status == BlocStatus.resendVerificationSuccess) {
        token = event.message;
        showSnackBar(context, 'Verification code sent');
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }



  Future<void> _registerDriver() async {
    _authCubit.registerDriver(firstName: widget.firstName, otherNames: widget.otherNames, phone: widget.phone, email: widget.email, password: widget.password);
  }

  verifyAuthCode(BuildContext ctx) {
    if (!validateAndSaveOnSubmit(ctx)) {
      return;
    }
    _authCubit.verifyAuthCode(code: code, token: token);
  }

  Future<void> _sendVerificationCode() async {
    _authCubit.sendVerificationCode(phone:widget.phone, resend: true);
  }

}
