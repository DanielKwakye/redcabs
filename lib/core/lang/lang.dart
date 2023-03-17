import 'package:auto_localized/annotations.dart';

/// Localization
/// add new local in the lang/ file and register it here
///
/// flutter pub run build_runner build --delete-conflicting-outputs -> to build the locales
@AutoLocalized(
  locales: [
    AutoLocalizedLocale(
      languageCode: 'en',
      countryCode: 'US',
      translationsFiles: ['lang/en.json'],
    ),
    AutoLocalizedLocale(
      languageCode: 'nl',
      countryCode: 'NL',
      translationsFiles: ['lang/nl.json'],
    ),
  ],
)
class $Strings {}