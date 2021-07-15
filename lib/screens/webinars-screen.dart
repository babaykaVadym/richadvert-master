import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';
import 'package:rich_advert_app/screens/timetable-screen.dart';
import 'package:rich_advert_app/screens/webinar-details-screen.dart';
import 'package:rich_advert_app/widgets/search.dart';

class WebinarsScreen extends StatelessWidget {
  static appBar(context) {
    var webinarsState = Provider.of<WebinarsState>(context, listen: false);
    var searchList = List<String>();
    webinarsState.webinars.forEach((webinar) {
      searchList.add(webinar.name.toLowerCase());
    });
    return AppBar(
      title: Text(getTranslated(context, "Записи вебинаров")),
      actions: [
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            Navigator.pushNamed(context, TimetableScreen.routeName);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: Search(searchList));
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var webinarsState = Provider.of<WebinarsState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          itemCount: webinarsState.webinars.length,
          itemBuilder: (context, index) {
            return _buildContainer(
                data: webinarsState.webinars[index], context: context);
          }),
    );
  }

  Widget _buildContainer({Webinar data, BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        key: Key(data.id),
        elevation: 2.0,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return ChangeNotifierProvider<Webinar>.value(
                value: data,
                builder: (context, _) => WebinarDetailsScreen(),
              );
            }));
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4),
                  height: 90,
                  width: MediaQuery.of(context).size.width * .3,
                  color: kOrangeColor,
                ),
                SizedBox(
                  width: 14,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Column(
                    children: [
                      Text(
                        data.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${data.speaker} | ${data.date}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
