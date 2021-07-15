import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/main.dart';
import 'package:rich_advert_app/screens/splash-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsScreen extends StatefulWidget {
  static String routeName = "/profile-settings";

  @override
  _ProfileSettingsScreenState createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  var selectedLang = SelectedLanguage.rus;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _isRegistered;

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadEmail();
  }

  Future<void> _logOut() async {
    final SharedPreferences prefs = await _prefs;

    _isRegistered = prefs.setBool("isRegistered", false).then((bool success) {
      return _isRegistered;
    });
  }

  void _changeLanguage(SelectedLanguage language) async {
    var langCode = language == SelectedLanguage.rus ? "ru" : "uk";

    Locale _locale = await setLocale(langCode);
    App.setLocale(context, _locale);
  }

  var username = ValueNotifier("");
  var email = ValueNotifier("");

  loadUsername() async {
    final SharedPreferences prefs = await _prefs;

    username.value = prefs.getString('username') ?? '';
  }

  loadEmail() async {
    final SharedPreferences prefs = await _prefs;

    email.value = prefs.getString('email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    selectedLang = Localizations.localeOf(context).languageCode == "ru"
        ? SelectedLanguage.rus
        : SelectedLanguage.uk;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Профиль")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ValueListenableBuilder(
                    valueListenable: username,
                    builder: (context, snapshot, _) {
                      return Text(
                        getTranslated(context, "Ваш адрес электронной почты:") +
                            "\n${email.value}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.caption,
                      );
                    })),
            SizedBox(
              height: 32,
            ),
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kOrangeColor,
                    radius: 36,
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {},
                    child: Text(
                        getTranslated(context, "Загрузить фото").toUpperCase(),
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              getTranslated(context, "Имя:"),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 4,
            ),
            ValueListenableBuilder(
                valueListenable: username,
                builder: (context, snapshot, _) {
                  return Text(
                    username.value,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .apply(fontSizeDelta: 4),
                  );
                }),
            SizedBox(
              height: 32,
            ),
            Text(
              getTranslated(context, "Язык профиля:"),
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              children: [
                Radio(
                  value: SelectedLanguage.rus,
                  groupValue: selectedLang,
                  onChanged: (SelectedLanguage value) {
                    _changeLanguage(value);
                    setState(() {
                      selectedLang = value;
                    });
                  },
                ),
                Text('Русский'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: SelectedLanguage.uk,
                  groupValue: selectedLang,
                  onChanged: (SelectedLanguage value) {
                    _changeLanguage(value);
                    setState(() {
                      selectedLang = value;
                    });
                  },
                ),
                Text('Українська'),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: () {
                    Widget cancelButton = FlatButton(
                      child: Text(
                        getTranslated(context, "отменить").toUpperCase(),
                        style: TextStyle(color: kOrangeColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    Widget continueButton = FlatButton(
                      child: Text(
                        getTranslated(context, "выйти").toUpperCase(),
                        style: TextStyle(color: kOrangeColor),
                      ),
                      onPressed: () {
                        _logOut();
                        Navigator.pushNamedAndRemoveUntil(
                            context, SplashScreen.routeName, (route) => false);
                      },
                    );

                    AlertDialog alert = AlertDialog(
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: kYellowColor,
                            child: SvgPicture.asset(
                              "assets/ic-logo.svg",
                              color: kBlackColor,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(getTranslated(context,
                                  "Вы уверенны что хотите выйти из профиля?"))),
                        ],
                      ),
                      // content: ,
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: Text(
                    getTranslated(context, "ВЫЙТИ ИЗ ПРОФИЛЯ"),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .apply(color: kOrangeColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum SelectedLanguage { uk, rus }
