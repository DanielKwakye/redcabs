import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// constant colors same in dark and light mode
const kCodeBackgroundColor = Color(0xff1E1E1E);
const kAppFaintBlack = Color(0xff202021);
const kAppGray = Color(0xff666666);
const kAppGrayInLightMode = Color(0xff666666);//Color(0xff666666);
const kAppGrayInDarkMode = Color(0xff999999);//Color(0xff666666);
const kAppLightGray2 = Color(0xffF6F6F6);
const kAppLightGray = Color(0xffF7F7F7);
const kAppWhite = Color(0xffFFFFFF);
const kAppBlue = Color(0xff4595D0);
// const kAppBlack = Colors.black;
const kAppBlack = Color(0xff101010);
const kAppRed = Color(0xffF04A44);
const kAppGreen =  Color(0xff004c36);
const kOutLine = Color(0xffEDF0F5);
const kAppGold = Color(0xffE49C59);
const kDisabledGrey = Color(0xffC4C4C4);
const accent = Color(0xff000000); //Color(0xffda1c36);
const primary = Color(0xffF04A44); //Colors.black;
const border = Color(0xffDEDEDE);
const gray = Color(0xffF0F0F0);
const ash = Color(0xff9699A8);
const lightGray = Color(0xffEDF0F5);

/// light mode colors
const kLightPrimaryColor = kAppRed;
const kLightOnPrimaryColor = kAppWhite;
const kLightSecondaryColor = kAppBlack;
const kLightOnSecondaryColor = Color(0xffFFFFFF);
const kLightBackgroundColor = kAppWhite;
const kLightOnBackgroundColor = kAppBlack;
const kLightErrorColor = kAppRed;
const kLightOnErrorColor = kAppWhite;
const kLightOutlineColor = kOutLine;

/// dark mode colors
const kDarkPrimaryColor = kAppRed;
const kDarkOnPrimaryColor = kAppWhite;
const kDarkSecondaryColor = kAppBlack;
const kDarkOnSecondaryColor = kAppWhite;
const kDarkBackgroundColor = kAppBlack;
const kDarkOnBackgroundColor = kAppWhite;
const kDarkErrorColor = kAppRed;
const kDarkOnErrorColor = Color(0xffFFFFFF);
const kDarkOutlineColor = Color(0xff2C2C2C);

// provider colors
const boltGreen = Color(0xff53C492);

/// UI overlay -> Configure app status bar and android navigation bar here
void setSystemUIOverlays({
  Color? statusBarColor = Colors.transparent, // for android only
  Brightness statusBarIconBrightness = Brightness.dark, //android // Brightness.dark for  statusBarIconBrightness means dark icons
  Brightness statusBarBrightness = Brightness.light, // ios // Brightness.dark for statusBarBrightness - means white icons
  Color? navigationBarColor,
  Brightness navigationBarIconBrightness = Brightness.dark, // android
}) =>
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle().copyWith(
        statusBarColor: statusBarColor ?? Colors.transparent, // configure app status bar color
        systemNavigationBarColor: navigationBarColor, //?? ThemeConfig.kColorScheme.background, // configure app navigation bar color
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarDividerColor: navigationBarColor, //?? ThemeConfig.kColorScheme.background,
        systemNavigationBarIconBrightness: navigationBarIconBrightness,
        statusBarBrightness: statusBarBrightness,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
);

/// using  Google Font Inter
/// ref -> https://material.io/design/typography/the-type-system.html#type-scale
/// Currently using the inter google font. We can change the font to any google font over here

// const _defaultFont = GoogleFonts.quicksandTextTheme;

/// Dark Theme Mode
darkTheme(BuildContext context) => ThemeData(
    textTheme: Theme.of(context).textTheme.copyWith(
      headlineMedium: const TextStyle(color: kAppWhite),
      headlineSmall: const TextStyle(color: kAppWhite),
      titleLarge: const TextStyle(color: kAppWhite),

      bodySmall: const TextStyle(color: kAppWhite),
      bodyMedium: const TextStyle(color: kAppWhite),
      bodyLarge: const TextStyle(color: kAppWhite),
      titleMedium: const TextStyle(color: kAppWhite),
      titleSmall: const TextStyle(color: kDarkOnPrimaryColor),


    ),
    fontFamily: 'AppFont',
    dividerColor: kDarkOutlineColor,
    scaffoldBackgroundColor: kDarkBackgroundColor,
    primaryColor: kDarkPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: kDarkBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: kDarkOnPrimaryColor),
      toolbarTextStyle: TextStyle(color: kDarkOnPrimaryColor),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: kDarkOnBackgroundColor,
    ), colorScheme: ColorScheme.fromSwatch()
        .copyWith(
      primary: kDarkPrimaryColor,
      onPrimary: kAppGrayInDarkMode,
      secondary: kDarkSecondaryColor,
      onSecondary: kDarkOnSecondaryColor,
      error: kDarkErrorColor,
      onError: kDarkOnErrorColor,
      background: kDarkBackgroundColor,
      onBackground: kDarkOnBackgroundColor,
      brightness: Brightness.dark,
      outline: kDarkOutlineColor,
      onSurface: kAppGrayInDarkMode,
      // surface: const Color(0xff1E2226), // linked in
      surface: const Color(0xff202021), // figma
      // surface: const Color(0xff242526), // facebook dark mode card
    ).copyWith(background: kDarkBackgroundColor)

);



/// Light Theme Mode
lightTheme(BuildContext context) => ThemeData(
    textTheme: Theme.of(context).textTheme.copyWith(
      headlineMedium: const TextStyle(color: kAppFaintBlack),
      headlineSmall: const TextStyle(color: kAppFaintBlack),
      titleLarge: const TextStyle(color: kAppFaintBlack),


      bodySmall: const TextStyle(color: kAppFaintBlack),
      bodyMedium: const TextStyle(color: kAppFaintBlack),
      bodyLarge: const TextStyle(color: kAppFaintBlack),
      titleMedium: const TextStyle(color: kAppFaintBlack),
      titleSmall: const TextStyle(color: kLightOnPrimaryColor),
    ),
    fontFamily: 'AppFont',
    dividerColor: kLightOutlineColor,
    scaffoldBackgroundColor: kLightBackgroundColor,
    primaryColor: kLightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: kLightBackgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: kLightOnPrimaryColor),
      toolbarTextStyle: TextStyle(color: kLightOnPrimaryColor),
    ),
    tabBarTheme: const TabBarTheme(
        labelColor: kLightOnBackgroundColor
    ), colorScheme: ColorScheme.fromSwatch()
        .copyWith(
        primary: kLightPrimaryColor,
        onPrimary: kAppGray,
        secondary: kLightSecondaryColor,
        onSecondary: kLightOnSecondaryColor,
        onSurface: kAppGrayInLightMode,
        error: kLightErrorColor,
        onError: kLightOnErrorColor,
        background: kLightBackgroundColor,
        onBackground: kLightOnBackgroundColor,
        brightness: Brightness.light,
        outline: kLightOutlineColor,
       surface: const Color(0xfff0c0c2)

    ).copyWith(background: kLightBackgroundColor)

);

/// theme configuration
// class ThemeConfig {
//   static double kDeviceWidth = 0;
//   static double kDeviceHeight = 0;
//   static late ThemeData kTheme;
//   static late TextTheme kTextTheme;
//   static late ColorScheme kColorScheme;
//
//   /// called on the initial page of the application
//   static void init(BuildContext context) {
//     kTheme = Theme.of(context);
//     kColorScheme = kTheme.colorScheme;
//     kTextTheme = kTheme.textTheme;
//     var size = MediaQuery.of(context).size;
//     kDeviceWidth = size.width;
//     kDeviceHeight = size.height;
//   }
//
//   /// mobile view
//   static bool get kIsMobile => kDeviceWidth < 650;
//
//   /// tablet view
//   static bool get kIsTablet => kDeviceWidth >= 650 && kDeviceWidth < 1080;
// }
