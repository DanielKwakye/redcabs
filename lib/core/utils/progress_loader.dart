import 'dart:async';

import 'package:flutter/material.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:redcabs_mobile/core/utils/constants.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';

class ProgressLoader {

  static ProgressDialog? _progressDialog;
  static const _inactivityTimeout = Duration(seconds: 15);
  static Timer? _keepAliveTimer;


  static Future<void> show(BuildContext context, {String text= "Please hold on ..."}) async {
    _progressDialog = ProgressDialog(
      context: context,
      backgroundColor: primary,
      textColor: Colors.white,
      backgroundOverlay: Colors.black,
      assetImageName: kAppLogo,
      loadingText: text,
    );

    if(_keepAliveTimer != null){
      _keepAliveTimer?.cancel();
      _keepAliveTimer = null;
    }

    _keepAliveTimer =  Timer(_inactivityTimeout, () async{
      await ProgressLoader.hide();
    });

    _progressDialog?.show();
  }

  static Future<void> hide() async{

    _keepAliveTimer?.cancel();

    if(_progressDialog != null && _progressDialog!.isShowing){
      _progressDialog?.dismiss();
      _progressDialog = null;
    }
  }

}