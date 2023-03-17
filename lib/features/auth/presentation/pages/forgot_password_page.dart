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

class ForgotPasswordPage extends StatefulWidget {

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordPageController createState() => ForgotPasswordPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _ForgotPasswordPageView extends WidgetView<ForgotPasswordPage, ForgotPasswordPageController> {

  const _ForgotPasswordPageView(ForgotPasswordPageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            const SharedSliverAppBar(pageTitle: ''),
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
                    child: Text('Forgot Password', textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Let's verify your dossier number",
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
                                        label: 'Dossier number',
                                        validator: state.required,
                                        inputType : TextInputType.emailAddress,
                                        placeHolder: 'eg. 34',
                                        controller: state.dossierController,

                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      BlocBuilder<AuthCubit, AuthState>(
                                        bloc: state._authCubit,
                                        builder: (ctx, authState) {
                                          return SharedButtonWidget(
                                            loading: authState.status == BlocStatus.verificationInProgress || authState.status == BlocStatus.checkingDossierInProgress,
                                            text: Strings.submit.get(),
                                            expand: true,
                                            icon: const SizedBox(width: 15, child: Icon(Icons.person, size: 18, color: kAppWhite)),
                                            appearance: Appearance.primary,
                                            onPressed: (){
                                              state.checkDossierNumber(ctx);
                                            },
                                          );
                                        },
                                      )
                                    ],
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

class ForgotPasswordPageController extends State<ForgotPasswordPage> with FormMixin {
  late AuthCubit _authCubit;
  late StreamSubscription<AuthState> listener;
  final dossierController = TextEditingController();
  final passwordController = TextEditingController();
  String? phone;


  @override
  Widget build(BuildContext context) => _ForgotPasswordPageView(this);

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    listener  = _authCubit.stream.listen((event) async {

      if(event.status == BlocStatus.checkingDossierError) {
        showSnackBar(context, event.message);
      }

      if(event.status == BlocStatus.checkingDossierSuccessful) {
        phone = event.message;
        _sendVerificationCode();
      }

      if (event.status == BlocStatus.verificationSuccess) {
        context.push(forgotPasswordVerifyOtpPageRoute, extra: {
          'phone': phone,
          'dossier': dossierController.text,
          'token': event.message
        });
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    listener.cancel();
  }

  checkDossierNumber(BuildContext ctx){
    if(!validateAndSaveOnSubmit(ctx)){
      return;
    }
    _authCubit.checkIfDossierExist(dossier: dossierController.text);

  }

  Future<void> _sendVerificationCode() async {
    _authCubit.sendVerificationCode(phone: phone!);
  }




}