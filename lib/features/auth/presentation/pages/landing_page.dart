import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_button_widget.dart';

import '../../../../core/lang/lang.al.dart';
import '../../../../core/utils/constants.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = sizeOfMediaQuery(context);
    final theme = themeOf(context);

    return Scaffold(

        body: Stack(
          children: [

            Container(
              height: size.height/2,
              color: kAppRed.withOpacity(0.8),
              width: double.infinity,
              child: Image.asset(kGiphy, fit: BoxFit.cover,),
            ),
            Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  kAppRed.withOpacity(0.3),
                  kAppRed,
                  kAppRed
                ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),

              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: size.height * 0.65,
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 50, height: 50,
                            child: Image.asset(kAppLogo),
                          ),
                          const SizedBox(height: 10,),
                          Text(Strings.welcome.get(), style: theme.textTheme.titleLarge?.copyWith(color: kAppWhite, fontWeight: FontWeight.bold ),),
                          Text(Strings.rightAppForYou.get(), style: theme.textTheme.bodyMedium?.copyWith(color: kAppWhite, fontWeight: FontWeight.w700 ), textAlign: TextAlign.center,),
                          const Spacer(),
                          Text(Strings.haveAccountQ.get(), style: theme.textTheme.bodyMedium?.copyWith(color: kAppWhite, fontWeight: FontWeight.w700 ),),
                          const SizedBox(height: 20,),
                          SharedButtonWidget(text: Strings.yesIDo.get(), backgroundColor: Colors.white, textColor: Colors.black, expand: true, onPressed: () {
                            context.push(logInPageRoute);
                          },),
                          const SizedBox(height: 10,),
                          SharedButtonWidget(text: Strings.noIDont.get(), expand: true, outlineColor: Colors.transparent, appearance: Appearance.dark,  onPressed: () {
                            context.push(signUpPageRoute);
                          },),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  )
              ),
            )

          ],
        )
    );

  }

}
