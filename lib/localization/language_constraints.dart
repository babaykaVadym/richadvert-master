import 'package:flutter/material.dart';
import 'package:rich_advert_app/localization/lang-localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String UKRAINIAN = 'uk';
const String RUSSIAN = 'ru';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? RUSSIAN;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case UKRAINIAN:
      return Locale(UKRAINIAN, 'UK');
    case RUSSIAN:
      return Locale(RUSSIAN, "RU");
    default:
      return Locale(RUSSIAN, 'RU');
  }
}

String getTranslated(BuildContext context, String key) {
  return LangLocalization.of(context).translate(key);
}
