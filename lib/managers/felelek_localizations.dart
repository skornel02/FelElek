import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _keyLangCode = "key_langCode";

String locText(BuildContext context,
    {@required String key, List<String> args}) {
  return FelElekLocalizations.of(context)?.translate(key, args: args);
}

Future<String> locTextContextless(
    {@required String key, List<String> args}) async {
  return await FelElekLocalizationsNoContext.translate(key, args: args);
}

Future<Locale> getPreferredLocale() async {
  String preferredLangCode = (await getPreferredLangCode());
  print("preferredLangCode:  $preferredLangCode");
  if (preferredLangCode != null) {
    return Locale(
      preferredLangCode,
    );
  }
  return null; //Locale("en", "EN");
}

setPreferredLocale(Locale preferredLocale) async {
  String preferredLangCode = preferredLocale.languageCode;
  if (preferredLangCode != null) {
    setPreferredLangCode(preferredLangCode);
  }
}

Future<String> getPreferredLangCode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String langCode = prefs.getString(_keyLangCode);
  if (langCode == null) {
    langCode = "en";
  }
  return langCode;
}

Future<void> setPreferredLangCode(String langCode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(_keyLangCode, langCode);
  return;
}

List<Locale> getSupportedLocales() {
  List<Locale> locales = [Locale('en', "EN"), Locale('hu', "HU")];

  return locales;
}

class FelElekLocalizationsNoContext {
  static Map<String, String> localizedStrings;

  static Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String preferredLangCode = await getPreferredLangCode();
    String jsonString =
        await rootBundle.loadString('assets/langs/$preferredLangCode.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  static Future<String> translate(String key,
      {@required List<String> args}) async {
    String nullCheckAndReturn(String text) {
      if (text == null) {
        return "ERROR: KEY NOT FOUND";
      }
      return text;
    }

    if (localizedStrings == null) {
      await load();
    }

    print("locale: translate args: $args");

    String text = localizedStrings[key];
    if (args == null) {
      return nullCheckAndReturn(text);
    }

    print("locale: translate  args length: ${args.length}");

    for (int i = 0; i < args.length; i++) {
      print("locale: translate iteration: $i");
      text = text.replaceFirst(RegExp('{}'), args[i]);
    }
    return nullCheckAndReturn(text);
  }
}

class FelElekLocalizations {
  Locale locale;

  FelElekLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static FelElekLocalizations of(BuildContext context) {
    return Localizations.of<FelElekLocalizations>(
        context, FelElekLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load(Locale l) async {
    locale = l;
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/langs/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, {@required List<String> args}) {
    String nullCheckAndReturn(String text) {
      if (text == null) {
        return "ERROR: KEY NOT FOUND";
      }
      return text;
    }

    String text = _localizedStrings[key];

    if (args == null) {
      return nullCheckAndReturn(text);
    }

    print("locale: translate  args length: ${args.length}");

    for (int i = 0; i < args.length; i++) {
      print("locale: translate  iter: $i");
      text = text.replaceFirst(RegExp('{}'), args[i]);
    }
    return nullCheckAndReturn(text);
  }

  String translateFromList({@required String key, @required int index}) {
    List<String> textList = jsonDecode(_localizedStrings[key]);
    String text = textList[index];
    return text;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<FelElekLocalizations> delegate =
      _FelElekLocalizationsDelegate();
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _FelElekLocalizationsDelegate
    extends LocalizationsDelegate<FelElekLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _FelElekLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'hu'].contains(locale.languageCode);
  }

  @override
  Future<FelElekLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    FelElekLocalizations localizations = new FelElekLocalizations(locale);
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(_FelElekLocalizationsDelegate old) => false;
}
