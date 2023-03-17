import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/mixins/form_mixin.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_button_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_text_field_widget.dart';

import '../../../../core/lang/lang.al.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../data/store/auth_cubit.dart';
import '../../data/store/auth_state.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageController createState() => LoginPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _LoginPageView extends WidgetView<LoginPage, LoginPageController> {

  const _LoginPageView(LoginPageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            SharedSliverAppBar(pageTitle: Strings.login.get()),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: kToolbarHeight,),
                  SizedBox(
                    width: 80, height: 80,
                    child: Image.asset(kAppLogo),
                  ) ,
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Welcome to Redcabs!', textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("You've been away too long...",
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  AnimationConfiguration.synchronized(
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 800),
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Form(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SharedTextFieldWidget(
                                        label: 'Email',
                                        onSaved: (value) {},
                                        validator: state.required,
                                        inputType : TextInputType.emailAddress,
                                        placeHolder: 'yourname@example.com',
                                        controller: state.emailController,

                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SharedTextFieldWidget(
                                        label: 'Password',
                                        isPassword: true,
                                        validator: state.required,
                                        placeHolder: 'Enter your password here',
                                        controller: state.passwordController,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: (){
                                            context.push(forgotPasswordPageRoute);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Forgot Password ?',
                                                style: TextStyle(color: theme.colorScheme.onPrimary),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      BlocBuilder<AuthCubit, AuthState>(
                                        bloc: state._authCubit,
                                        builder: (ctx, authState) {
                                          return SharedButtonWidget(
                                            loading: authState.status == BlocStatus.loginProgress,
                                            text: Strings.login.get(),
                                            expand: true,
                                            icon: const SizedBox(width: 15, child: Icon(Icons.person, size: 18, color: kAppWhite)),
                                            appearance: Appearance.primary,
                                            onPressed: (){
                                              state.driverLogin(ctx);
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40,),
                              GestureDetector(
                                onTap: (){
                                  context.push(signUpPageRoute);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: Strings.dontHaveAccountQ.get(),
                                      style: TextStyle(color: theme.colorScheme.onPrimary),
                                      children: const <TextSpan>[
                                        TextSpan(text: ' Sign Up', style: TextStyle(color: kAppBlue)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10,),

                              // const Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 20),
                              //   child:  CustomTermsPrivacyWidget(),
                              // ),

                              const SizedBox(height: kToolbarHeight,),
                            ]),
                      ),
                    ),


                  ),


                ],
              ),
            )
          ],
        )
    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class LoginPageController extends State<LoginPage> with FormMixin {
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) => _LoginPageView(this);

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    listener  = _authCubit.stream.listen((event) async {
      if(event.status == BlocStatus.loginSuccessful) {
        // when authentication is successful
        context.go(fAdminPageRoute);
      }
      if(event.status == BlocStatus.loginFailed) {
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

  driverLogin(BuildContext ctx){
    if(!validateAndSaveOnSubmit(ctx)){
      return;
    }
    _authCubit.login(email: emailController.text, password: passwordController.text);

  }



}