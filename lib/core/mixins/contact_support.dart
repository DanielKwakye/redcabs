
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';

class ContactSupportMixin {

  void chatSupport() async{
      emailSupport();
  }

  void callSupport() async {

    final Uri telLaunchUri = Uri(
      scheme: 'tel',
      path: companyPhone,
    );

    try{
      await canLaunchUrl(Uri.parse(telLaunchUri.toString())) ? launchUrl(Uri.parse(telLaunchUri.toString()))  : throw 'Could not launch $telLaunchUri';
    }catch (error){
    if (kDebugMode) {
      print(error);
    }
    }


  }

  browserSupport() async{
    final Uri httpLaunchUri = Uri(
      scheme: 'https',
      path: companyWebsite,
    );

    try{
      await canLaunchUrl(Uri.parse(httpLaunchUri.toString())) ? launchUrl(Uri.parse(httpLaunchUri.toString()))  : throw 'Could not launch $httpLaunchUri';
    }catch (error){
      if (kDebugMode) {
        print(error);
      }
    }

  }

  void emailSupport({String subject: 'Assistance needed'}) async{

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: companyEmail,
      query: _encodeQueryParameters(<String, String>{
        'subject': subject
      }),
    );

    try{
      await canLaunchUrl(Uri.parse(emailLaunchUri.toString())) ? launchUrl(Uri.parse(emailLaunchUri.toString()))  : throw 'Could not launch $emailLaunchUri';
    }catch (error){
      if (kDebugMode) {
        print(error);
      }
    }

  }

  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }


}