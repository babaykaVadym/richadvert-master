import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';

class TimetableScreen extends StatelessWidget {
  static String routeName = "/timetable";

  @override
  Widget build(BuildContext context) {
    var webinars = Provider.of<WebinarsState>(context, listen: true).timetable;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Расписание вебинаров")),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Builder(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 8),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Text(
                        getTranslated(context, "Предстоящие события"),
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.caption,
                      )),
                  ...webinars.map((webinar) {
                    return _buildCard(webinar, context);
                  }),
                  SizedBox(
                    height: 24,
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Card _buildCard(Webinar webinar, BuildContext context) {
    var state = Provider.of<WebinarsState>(context);
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * .91,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${webinar.date.toUpperCase()} по КИЕВУ, МСК",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 157,
              width: 314,
              color: kDarkGreyColor,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              webinar.name,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: webinar.isJoined
                  ? RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      onPressed: null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.library_add_check),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTranslated(context, "ВЫ УЧАСТВУЕТЕ")),
                        ],
                      ),
                    )
                  : RaisedButton(
                      color: kYellowColor,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      onPressed: () {
                        state.toggleJoinWebinar(webinar);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.library_add),
                          SizedBox(
                            width: 8,
                          ),
                          Text(getTranslated(context, "ПРИСОЕДЕНИТЬСЯ")),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
