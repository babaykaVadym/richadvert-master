import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/screens/chat-screen.dart';
import 'package:rich_advert_app/screens/course-details-screen.dart';
import 'package:rich_advert_app/screens/home-screen.dart';
import 'package:rich_advert_app/screens/notifications-screen.dart';
import 'package:rich_advert_app/screens/webinars-screen.dart';
import 'package:rich_advert_app/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  static String routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar get _getAppBar {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen.appBar(context);
      case 1:
        return CourseDetailsScreen.appBar(context);
      case 2:
        return WebinarsScreen.appBar(context);
      case 3:
        return ChatScreen.appBar(context);
      case 4:
        return NotificationsScreen.appBar(context);
      default:
        return AppBar(
          title: Text(getTranslated(context, "Обучение Richadvert")),
        );
    }
  }

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreen(_onItemTapped);
      case 1:
        return CourseDetailsScreen();
      case 2:
        return WebinarsScreen();
      case 3:
        return ChatScreen();
      case 4:
        return NotificationsScreen();

      default:
        return HomeScreen(_onItemTapped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar,
      drawer: DrawerWidget(),
      body: SafeArea(child: _getScreen()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: getTranslated(context, 'Главная'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: getTranslated(context, 'Курсы'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline_rounded),
            label: getTranslated(context, 'Вебинары'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: getTranslated(context, 'Чат'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: getTranslated(context, 'Уведомления'),
          ),
        ],
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: kMidGreyColor,
        // unselectedLabelStyle: ,
      ),
    );
  }
}
