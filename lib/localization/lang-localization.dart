import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LangLocalization {
  LangLocalization(this.locale);

  final Locale locale;
  static LangLocalization of(BuildContext context) {
    return Localizations.of<LangLocalization>(context, LangLocalization);
  }

  Map<String, String> _localizedValues;

  Future<void> load() async {
    String jsonStringValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedValues[key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<LangLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<LangLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['uk', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<LangLocalization> load(Locale locale) async {
    LangLocalization localization = new LangLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LangLocalization> old) => false;
}
