import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/screens/faq-screen.dart';
import 'package:rich_advert_app/screens/favorites-screen.dart';
import 'package:rich_advert_app/screens/profile-settings.dart';
import 'package:rich_advert_app/screens/timetable-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadEmail();
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
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                    valueListenable: username,
                    builder: (context, snapshot, _) {
                      return Text(
                        snapshot,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .apply(color: kWhiteColor),
                      );
                    }),
                SizedBox(
                  height: 5,
                ),
                ValueListenableBuilder(
                    valueListenable: email,
                    builder: (context, snapshot, _) {
                      return Text(
                        snapshot,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .apply(color: kWhiteColor),
                      );
                    }),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              getTranslated(context, 'Расписание вебинаров'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TimetableScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              getTranslated(context, 'Настройки профиля'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileSettingsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.star_outline),
            title: Text(
              getTranslated(context, 'Избранное'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FavoritesScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text(
              getTranslated(context, 'FAQ'),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FAQScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
