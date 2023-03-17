// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unnecessary_const, constant_identifier_names

// **************************************************************************
// AutoLocalizedGenerator
// **************************************************************************

import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@immutable
class AutoLocalizedData {
  static const supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('nl', 'NL'),
  ];

  static const delegate = AutoLocalizationDelegate(supportedLocales);

  static const localizationsDelegates = [
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    delegate,
  ];
}

extension AutoLocalizedContextExtension on BuildContext {
  List<Locale> get supportedLocales => AutoLocalizedData.supportedLocales;

  List<LocalizationsDelegate> get localizationsDelegates =>
      AutoLocalizedData.localizationsDelegates;

  String translate(
    LocalizedString string, [
    String arg1 = "",
    String arg2 = "",
    String arg3 = "",
    String arg4 = "",
    String arg5 = "",
  ]) =>
      string.when(
        plain: (string) => string.get(this),
        arg1: (string) => string.get(arg1, this),
        arg2: (string) => string.get(arg1, arg2, this),
        arg3: (string) => string.get(arg1, arg2, arg3, this),
        arg4: (string) => string.get(arg1, arg2, arg3, arg4, this),
        arg5: (string) => string.get(arg1, arg2, arg3, arg4, arg5, this),
      );
}

@immutable
class Strings {
  const Strings._();
  static const welcome = PlainLocalizedString(
    key: 'welcome',
    values: {
      'en_US': '''Welcome to Redcabs''',
      'nl_NL': '''Welkom''',
    },
  );

  static const rightAppForYou = PlainLocalizedString(
    key: 'right_app_for_you',
    values: {
      'en_US':
          '''The right App for anyone who wants to become an independent driver for platforms such as Amigoo, Uber, and Bolt''',
      'nl_NL':
          '''De juiste app voor iedereen die zelfstandig chauffeur wil worden voor platformen als Amigoo, Uber en Bolt''',
    },
  );

  static const haveAccountQ = PlainLocalizedString(
    key: 'have_account_q',
    values: {
      'en_US': '''Do you have an account?''',
      'nl_NL': '''Heb je een account?''',
    },
  );

  static const yesIDo = PlainLocalizedString(
    key: 'yes_i_do',
    values: {
      'en_US': '''Yes I do''',
      'nl_NL': '''Ja, ik wil''',
    },
  );

  static const noIDont = PlainLocalizedString(
    key: 'no_i_dont',
    values: {
      'en_US': '''No I don't''',
      'nl_NL': '''Nee, dat doe ik niet''',
    },
  );

  static const login = PlainLocalizedString(
    key: 'login',
    values: {
      'en_US': '''Login''',
      'nl_NL': '''Inloggen''',
    },
  );

  static const signup = PlainLocalizedString(
    key: 'signup',
    values: {
      'en_US': '''Sign up''',
      'nl_NL': '''Aanmelden''',
    },
  );

  static const alreadyHaveAccountQ = PlainLocalizedString(
    key: 'already_have_account_q',
    values: {
      'en_US': '''Already have an account?''',
      'nl_NL': '''Heb je al een account?''',
    },
  );

  static const dontHaveAccountQ = PlainLocalizedString(
    key: 'dont_have_account_q',
    values: {
      'en_US': '''Don't have an account?''',
      'nl_NL': '''Heb je geen account?''',
    },
  );

  static const youBeenAwayTooLong = PlainLocalizedString(
    key: 'you_been_away_too_long',
    values: {
      'en_US': '''You've been away too long...''',
      'nl_NL': '''Je bent te lang weggeweest...''',
    },
  );

  static const updatePassword = PlainLocalizedString(
    key: 'updatePassword',
    values: {
      'en_US': '''Update password''',
      'nl_NL': '''Update password''',
    },
  );

  static const update = PlainLocalizedString(
    key: 'update',
    values: {
      'en_US': '''Update''',
      'nl_NL': '''Update''',
    },
  );

  static const profile = PlainLocalizedString(
    key: 'profile',
    values: {
      'en_US': '''Profile''',
      'nl_NL': '''Profile''',
    },
  );

  static const submit = PlainLocalizedString(
    key: 'submit',
    values: {
      'en_US': '''Submit''',
      'nl_NL': '''Submit''',
    },
  );
}
