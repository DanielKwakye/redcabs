import 'package:flutter/cupertino.dart';

import '../utils/functions.dart';


class SettingMixin {

  void logOutOfDevice(BuildContext context){
      showHandyConfirmDialog(context, content: "You'll be logged out on this device", okTapped: () async {
        // await PreferenceHelper.removeUserFromFile();
        // changeScreen(context, OnboardingDecisionScreen.route, replace: true);
      });
  }

}