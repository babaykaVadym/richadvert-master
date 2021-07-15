import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/localization/lang-localization.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/lesson-model.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';
import 'package:rich_advert_app/screens/faq-screen.dart';
import 'package:rich_advert_app/screens/favorites-screen.dart';
import 'package:rich_advert_app/screens/home-page.dart';
import 'package:rich_advert_app/screens/lesson-screen.dart';
import 'package:rich_advert_app/screens/profile-settings.dart';
import 'package:rich_advert_app/screens/registration-screen.dart';
import 'package:rich_advert_app/screens/splash-screen.dart';
import 'package:rich_advert_app/screens/timetable-screen.dart';
import 'package:rich_advert_app/screens/webinar-details-screen.dart';
import 'package:rich_advert_app/theme.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WebinarsState()),
    ChangeNotifierProvider(create: (_) => CoursesState()),
  ], child: App()));
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(_locale);
    return MaterialApp(
      title: 'RichAdvert',
      theme: kThemeData,
      locale: _locale,
      supportedLocales: [
        Locale("ru", "RU"),
        Locale("uk", "UK"),
      ],
      localizationsDelegates: [
        LangLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      initialRoute: SplashScreen.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        SplashScreen.routeName: (context) => SplashScreen(),
        FAQScreen.routeName: (context) => FAQScreen(),
        FavoritesScreen.routeName: (context) => FavoritesScreen(),
        TimetableScreen.routeName: (context) => TimetableScreen(),
        RegistrationScreen.routeName: (context) => RegistrationScreen(),
        ProfileSettingsScreen.routeName: (context) => ProfileSettingsScreen(),
        LessonScreen.routeName: (context) => LessonScreen(Lesson()),
        WebinarDetailsScreen.routeName: (context) => WebinarDetailsScreen(),
      },
    );
  }
}
