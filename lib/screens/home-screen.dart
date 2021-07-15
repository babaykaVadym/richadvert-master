import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/screens/timetable-screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.changeIndex);
  final changeIndex;
  static appBar(context) => AppBar(
        title: Text(getTranslated(context, "Обучение Richadvert")),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 24,
            ),
            _buildTab(
                context: context,
                title: getTranslated(context, "Бесплатные курсы"),
                onTap: () {
                  //переход на вторую вкладку
                  changeIndex(1);
                }),
            _buildTab(
                context: context,
                title: getTranslated(context, "Записи вебинаров"),
                onTap: () {
                  //переход на третью вкладку
                  changeIndex(2);
                }),
            _buildTab(
                context: context,
                title: getTranslated(context, "Расписание вебинаров"),
                onTap: () {
                  Navigator.pushNamed(context, TimetableScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({String title, Function onTap, BuildContext context}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Card(
        elevation: 2.0,
        child: InkWell(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 4.1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    child: Icon(
                      Icons.arrow_forward,
                      color: kWhiteColor,
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
