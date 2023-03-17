
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/functions.dart';
import '../utils/progress_loader.dart';

class OnBoardingMixin {

  Future<bool> logIntoDriverAccount(BuildContext ctx,
      {required String userId,required String password, bool rememberMe = false}) async{
    return true;

    // try{

      // final pd = getAuthenticationApi();
      //
      // await ProgressLoader.show(ctx, text: "Attempting login ...");
      // final response = await pd.login(userId: userId, password: password);
      // await ProgressLoader.hide();
      //
      // if(!response.status){
      //   showHandyAlertDialog(ctx, title: "Sorry!", content: response.message);
      //   return false;
      // }
      //
      // if(response.extra["name"] == null){
      //   showHandyAlertDialog(ctx, content: response.message);
      //   return false;
      // }
      //
      // final id = response.extra["id"] ?? "";
      // final name = response.extra["name"] ?? "";
      //
      // final phone = response.extra["phone"] ?? "N/A";
      // final driverEmail = response.extra["driver_email"] ?? "";
      // final address = response.extra["address"] ?? "";
      //
      // //// prospective driver ////
      // final otherNames = response.extra["other_names"] ?? "";
      // final unlockDashboard = response.extra["unlock_dashboard"]?.toString()  ?? "false";
      // final userType = response.extra["driver_type"];
      //
      // final user = getIt<User>();
      //
      // notificationCount = response.extra['pending_push_notifications']?.toString() ?? "0";
      // print("notificationCount: ${response.extra['pending_push_notifications']?.toString()}");
      //
      //
      // if(user.registeredForPush == "false"){
      //
      //   print("setting ExternalUserId ...");
      //   await ProgressLoader.show(ctx, text: "Attempting login ...");
      //   var myCustomUniqueUserId = response.extra['id'];
      //   //await OneSignal.shared.removeExternalUserId();
      //   final setExtPushIdResponse = await OneSignal.shared.setExternalUserId(myCustomUniqueUserId);
      //   print("setExtPushIdResponse: $setExtPushIdResponse :: newDeviceId: $myCustomUniqueUserId");
      //   await ProgressLoader.hide();
      //
      //   if(setExtPushIdResponse['push']['success'] != null){
      //     if(setExtPushIdResponse['push']['success'] is bool){
      //       final status = setExtPushIdResponse['push']['success'] as bool;
      //       if(status){
      //         user.registeredForPush = "true";
      //       }
      //     }else if (setExtPushIdResponse['push']['success'] is int){
      //       final status = setExtPushIdResponse['push']['success'] as int;
      //       if(status == 1){
      //         user.registeredForPush = "true";
      //       }
      //     }
      //     print("registered for push: ${setExtPushIdResponse['push']['success']}");
      //
      //   }
      //
      // }
      //
      // // firebase authentication
      //
      // // if(fbAuth.FirebaseAuth.instance.currentUser == null){
      // //   debugPrint('firebase authenticating .... ');
      // //   await fbAuth.FirebaseAuth.instance.signInAnonymously();
      // // }
      //
      //
      // /// set bearer on login
      // bearerToken = response.extra["access_token"];
      //
      // // save credentials in shared preference
      //
      // user.id = id;
      // user.name = name;
      // user.otherNames = otherNames;
      // user.userId = userId;
      // user.phone = phone;
      // user.driverEmail = driverEmail;
      // user.unlockDashboard = unlockDashboard;
      // user.userType = userType; //prospective_driver, regular_driver,
      // user.accountType = "driver"; // driver, student
      // user.startWeek = response.extra['start_week'];
      // user.endWeek = response.extra['end_week'];
      // user.isValidEmail = response.extra['is_valid_email'];
      // user.enrolmentCompleted = response.extra['is_enrolment_completed'];
      // user.address = address;
      //
      // print("unlock dashboard: ${user.unlockDashboard}");
      //
      // // if(userType == "regular_driver"){
      // //   user.dossier = userId;
      // // }else if (userType == "prospective_driver"){
      // //
      // // }
      // user.dossier = response.extra['dossier'] ?? "";
      // user.driverEmail = userId;
      // user.prospectiveDriverStatus = response.extra['driver_info']['status'];
      // user.selectedServiceType = response.extra['driver_info']['service_type'];
      // user.timeRemainingForDashboardAccess =  response.extra['time_remaining'];
      // user.agreedToHouseRules =  response.extra['driver_info']['accepted_house_rules'] == "YES";
      // user.rentalsInProgress =   response.extra['rentals_in_progress'] ?? 0;
      //
      //
      // if(rememberMe){
      //   user.password = password;
      // }else{
      //   user.password = null;
      // }
      //
      // print("serviceType: ${user.selectedServiceType} userStatus: ${user.prospectiveDriverStatus}");

      // await PreferenceHelper.saveUserToFile();

    //   return true;
    //
    // }catch(exception){
    //   if (kDebugMode) {
    //     print(exception);
    //   }
    //   await ProgressLoader.hide();
    //   if(ctx.mounted){
    //     showSnackBarWithConnectionIssue(ctx);
    //     return false;
    //   }
    //
    // }

  }

  Future<bool> checkDossierWithServer(BuildContext context, {@required dossier}) async{
    return true;
    // try{

    //   final pd = getApi<VerificationApi>();
    //
    //   await ProgressLoader.show(context);
    //   final response = await pd.checkDossierNumber(dossier);
    //   await ProgressLoader.hide();
    //
    //   if(!response.status){
    //     showHandyAlertDialog(context, content: response.message);
    //     return {
    //       'status' : false
    //     };
    //   }
    //
    //   if( response.extra['enum'] == null || response.extra['phone'] == null ){
    //     showTechnicalIssueAlert(context);
    //     return {
    //       'status' : false
    //     };
    //   }
    //
    //   final enumValue = response.extra['enum'];
    //   final phone = response.extra['phone'];
    //
    //   return {
    //     'status' : true,
    //     'enumValue' : enumValue,
    //     'phone' : phone,
    //   };
    //
    // }catch(exception){
    //   print(exception);
    //   await ProgressLoader.hide();
    //   showSnackBarWithConnectionIssue(context);
    //   return {
    //     'status' : false
    //   };
    // }

  }

}