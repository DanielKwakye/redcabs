import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:redcabs_mobile/core/utils/extensions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/features/auth/data/repositories/auth_repository.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../features/shared/presentation/widgets/shared_border_widget.dart';
import '../../features/shared/presentation/widgets/shared_button_widget.dart';
import 'constants.dart';
import 'enums.dart';

/// Use this method to execute code that requires context in init state
onWidgetBindingComplete({required Function() onComplete, int duration = 1000}){
  WidgetsBinding.instance.addPostFrameCallback((_) => Timer(Duration(milliseconds: duration), onComplete));
}

AuthRepository getAuthenticationApi(){
  return getIt<AuthRepository>();
}


bool containsOnlyCaps({required String text}) {
  RegExp regEx = RegExp(r"^[A-Z]*$");
  return regEx.hasMatch(text);
}

void showTechnicalIssueAlert(BuildContext ctx){
  showHandyAlertDialog(ctx, title: "Sorry!", content: "A technical issue occurred, please contact admin.");
}

void showErrorAlert(BuildContext ctx, {required String content, void Function()? okTapped}){
  showHandyAlertDialog(ctx, title: "Sorry!", content: content ?? "", okTapped: okTapped??(){});
}

void showSnackBarWithConnectionIssue(BuildContext ctx, {Color backgroundColor= accent}){
  showSnackBar(ctx, "Unable to connect. Try again later!", backgroundColor: backgroundColor);
}

void showSuccessAlert(BuildContext ctx, {required String content, void Function()? okTapped}){
  showHandyAlertDialog(ctx, title: "Done!", content: content, okTapped: okTapped??(){});
}

void showHandyAlertDialog(BuildContext context, {String title = "Please note", String content = "", void Function()? okTapped}){
  showDialog(context: context, builder: (ctx) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: [

        TextButton(onPressed: (){
          Navigator.of(context).pop();
          okTapped??(){};
        }, child: const Text("OK"))
      ],
    );

  });

}


/// snackbar
void showSnackBar(BuildContext context, String message, {Color? background, Color? foreground, Appearance? appearance = Appearance.primary, Position position = Position.top,  Color? backgroundColor, bool action = false}) {

  var messenger = ScaffoldMessenger.of(context);
  final media = MediaQuery.of(context);

  messenger
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        // width: 200,
        duration: const Duration(milliseconds: 9000), // delay
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: appearance == null ? foreground ?? Theme.of(context).colorScheme.primary
                : kAppWhite,
          ),
        ),
        backgroundColor: appearance == null ? (background ?? Theme.of(context).colorScheme.onPrimary) :
        ((appearance == Appearance.error) ? kAppRed : ((appearance == Appearance.success) ? Colors.green : kAppBlue ))
        ,
        behavior: SnackBarBehavior.floating,
        action: action ? SnackBarAction(
          label: 'Dismiss',
          textColor: appearance == null ? (foreground ?? Theme.of(context).colorScheme.primary) : kAppWhite,
          onPressed: () => messenger.hideCurrentSnackBar(),
        ):null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        margin: position == Position.bottom ?   EdgeInsets.only(
            top: media.size.height - (media.size.height / 5),
            right: 20,
            left: 20) : null,
      ),
    );



}

/// convert figures in 1000s into k
String convertToCompactFigure(double numberToFormat) {

  final formattedNumber = NumberFormat.compactCurrency(
    decimalDigits: numberToFormat > 1000 ? 2 : 0,
    symbol: '',
  ).format(numberToFormat);

  return formattedNumber;
  // print('Formatted Number is: $_formattedNumber');

}


AccountType getAccountTypeFromString(String accountType){
  if(accountType == "driver"){
    return AccountType.driver;
  }else if(accountType == "student"){
    return AccountType.student;
  }
  return AccountType.unknown  ;
}

Future<Object?> changeScreen(BuildContext context, String destination, { bool replace= false , dynamic args= const {} }){
  if(replace) {
    return Navigator.of(context).pushNamedAndRemoveUntil(destination, (Route<dynamic> route) => false, arguments: args);
  } else {
    return Navigator.of(context).pushNamed(destination, arguments: args);
  }
}

String getFirstLetter(String words) {
  if(blank(words)) {
    return words;
  }
  return words[0];
}

String getInitials(String words) {

  if(blank(words)) {
    return words;
  }

  try{
    List<String> names = words.split(" ");
    String initials = "";
    int numWords = 2;

    if(numWords < names.length) {
      numWords = names.length;
    }
    for(var i = 0; i < numWords; i++){
      if(names[i].isNotEmpty){
        initials += names[i][0];
      }
    }
    return initials;
  }catch(e){
    return words[0];
  }
}

Color getChipCardColor(String name){
  if(name.toLowerCase().contains("uber")){
    return Colors.black;
  }else if(name.toLowerCase().contains("bolt")){
    return boltGreen;
  }else if(name.toLowerCase().contains("taxi")){
    return Colors.amber;//Color(0xffCCA119);
  }else if(name.toLowerCase().contains("arrears")){
    return const Color(0xffF04A44);
  }else if(name.toLowerCase().contains("cost")){
    return const Color(0xff909BFA);
  }else{
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0); // return random color
  }
}


String formatServiceToReadable(String service){
  final array = service.split('_');
  String str = '';
  for (var element in array) {
    str += element.capitalize();
    str += " ";
  }
  return str;
}


void showHandyConfirmDialog(BuildContext context, {String title = "Confirm", String content  = "", void Function()? okTapped, void Function()? onCancelTapped}){
  showDialog(context: context, builder: (ctx) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: [

        // cancel button
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          if(onCancelTapped != null){
            onCancelTapped();
          }
        }, child: const Text("Cancel")),

        // okay button
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          if(okTapped != null){
            okTapped();
          }
        }, child: const Text("OK"))

      ],
    );
  });

}


void showDecisionDialog(BuildContext context, {
  required VoidCallback onConfirmTapped,
  VoidCallback? onCancelTapped,
  required String title,
  bool showCancelButton = true,
  bool isDismissible = true,
  bool showCloseButton = true,
  String? subtitle,
  Map<String, dynamic> data = const  {}, String? confirmActionText, String? cancelActionText
}) {

  final theme = Theme.of(context);
  showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: theme.colorScheme.background,
      context: context,
      builder: (ctx) {
        return Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if(showCloseButton) ... {
                  Align(alignment: Alignment.topRight, child: CloseButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),),
                  const SharedBorderWidget(),
                },

                const SizedBox(height: 20,),
                Text(title, style: theme.textTheme.titleLarge,),

                if(subtitle != null)...{
                  const SizedBox(height: 10,),
                  Text(subtitle, style: TextStyle(color: theme.colorScheme.onBackground),),
                },

                const SizedBox(height: 20,),
                Row(
                  children: [
                    if(showCancelButton) ... [
                      // const SizedBox(width: 10,),
                      Expanded(child: SharedButtonWidget(text: cancelActionText ?? "Cancel", expand: true,
                        appearance: Appearance.dark,
                        onPressed: () {
                          Navigator.of(context).pop();
                          onCancelTapped?.call();
                        },
                      )),
                    ],
                    const SizedBox(width: 10,),

                    Expanded(
                        child: SharedButtonWidget(
                          text: confirmActionText ?? "Confirm", expand: true,
                          appearance: Appearance.primary,
                          onPressed: () {

                            Navigator.of(context).pop();

                            onConfirmTapped();
                          },
                        )),

                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        );
      });
}


/// Get formatted date
String getTimeAgo(DateTime date){

  final readableTime = timeago.format(date);
  return readableTime;

}

String getFormattedDateWithIntl(DateTime date, {String format = 'MMM yyyy'}){

  var formatBuild = DateFormat(format);
  var dateString = formatBuild.format(date);
  return dateString;

}


Future<Object?> pushScreenWithNamed(BuildContext context, String destination, { bool replaceAll = false , dynamic args = const {}, fullscreenDialog = false , rootNavigator = false}){
  if(replaceAll) {
    return Navigator.of(context, rootNavigator: rootNavigator ).pushNamedAndRemoveUntil(destination, (Route<dynamic> route) => false, arguments: args);
  } else {
    return Navigator.of(context, rootNavigator: rootNavigator ).pushNamed(destination, arguments: args);
  }
}

Future<Object?> pushScreenWithConstructor(BuildContext context,
    Widget classObject, { bool replaceAll = false, fullscreenDialog = false, rootNavigator = false }){
  if(replaceAll){
    return Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => classObject),
            (Route<dynamic> route) => false
    );
  }else{
    return Navigator.of(context, rootNavigator: rootNavigator ).push(MaterialPageRoute(builder: (context) => classObject, fullscreenDialog: fullscreenDialog));
  }
}

pop<T extends Object?>(BuildContext context, [T? result]){
  Navigator.of(context).pop(result);
}

String toCurrencyFormat(String value, {bool showCurrency = true}){
  if(double.tryParse(value) == null) {
    return value;
  }

  final newValue = double.parse(value);

  final oCcy = NumberFormat("#,##0.00", "en_US");
  final oCcyResult = oCcy.format(newValue);
  //return "GHS ${.toStringAsFixed(2)}";
  return showCurrency ? "$currency $oCcyResult" : oCcyResult;
}


ScreenType getScreenType(BuildContext context){
  final size = MediaQuery.of(context).size;
  final height = size.height;
  final width = size.width;
  if(width < 350 && height < 550){
    return ScreenType.small;
  }else if(width >= 550 && height < 700){
    return ScreenType.medium;
  }else{
    return ScreenType.long;
  }
}

dynamic goBack(BuildContext context, {dynamic args}){
  return Navigator.of(context).pop(args);
}

bool blank(dynamic text){
  if(text is bool){
    return text == false;
  }else if(text is DateTime){
    return text == null;
  }else if(text is TimeOfDay){
    return text == null;
  }
  return text == null || text == '' || text.length == 0;
}

ImagePickerFileType getFileType(String filePath){
  String? mimeStr = lookupMimeType(filePath);
  final fileType = mimeStr?.split('/');
  if(fileType !=null){
    return (fileType.contains('image')) ? ImagePickerFileType.image : ImagePickerFileType.document;
  }
  return ImagePickerFileType.document;
}

Size getScreenSize(BuildContext context) => MediaQuery.of(context).size;

void setAppSystemOverlay({bool useThemeOverlays = true, required ThemeData theme, bool strictlyUseDarkModeOverlays = false, strictlyUseLightModeOverlays = false}) {

  if(useThemeOverlays) {
    setSystemUIOverlays(
      statusBarColor: Colors.transparent,
      // for android only
      statusBarBrightness: theme.brightness,
      // IOS
      statusBarIconBrightness: theme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      // For android //
      navigationBarColor: theme.colorScheme.background,
      // for android only
      navigationBarIconBrightness: // visible on android only
      theme.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    );
  }

  else if(strictlyUseDarkModeOverlays) {
    setSystemUIOverlays(
      statusBarColor: Colors.transparent,
      // for android only
      statusBarBrightness: Brightness.dark,
      // IOS
      statusBarIconBrightness: Brightness.light,
      // For android //
      navigationBarColor: theme.colorScheme.background,
      // for android only
      navigationBarIconBrightness: // visible on android only
      theme.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      );
    }

    else if(strictlyUseLightModeOverlays) {
      setSystemUIOverlays(
        statusBarColor: Colors.transparent,
        // for android only
        statusBarBrightness: Brightness.light,
        // IOS
        statusBarIconBrightness: Brightness.dark,
        // For android //
        navigationBarColor: theme.colorScheme.background,
        // for android only
        navigationBarIconBrightness: // visible on android only
        theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      );
    }

}


String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' :'tablet';
}

///MediaQuery Height
Size sizeOfMediaQuery(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// Get theme
ThemeData themeOf(BuildContext context){
  return Theme.of(context);
}

/// Get arguments
Object? argumentsOf(BuildContext context) {
  return ModalRoute.of(context)?.settings.arguments;
}