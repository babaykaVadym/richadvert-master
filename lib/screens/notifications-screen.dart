import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';
import 'package:rich_advert_app/screens/webinar-details-screen.dart';

class NotificationsScreen extends StatelessWidget {
  static appBar(context) => AppBar(
        title: Text(getTranslated(context, "Уведомления")),
      );

  final expandedIndex = ValueNotifier(-1); //-1 = all closed

  @override
  Widget build(BuildContext context) {
    var joinedWebinars =
        Provider.of<WebinarsState>(context, listen: true).joinedWebinars;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        joinedWebinars.length == 0
            ? Center(
                child: Text(""),
              )
            : ValueListenableBuilder(
                valueListenable: expandedIndex,
                builder: (BuildContext context, dynamic value, Widget child) {
                  return ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      if (expandedIndex.value == index) {
                        expandedIndex.value = -1;
                      } else if (expandedIndex.value != index) {
                        expandedIndex.value = index;
                      }
                      // });
                    },
                    children: [
                      ...joinedWebinars.map(
                        (value) => _buildNotificationsRow(
                            context: context,
                            isExpanded: expandedIndex.value ==
                                joinedWebinars.indexOf(value),
                            data: value),
                      )
                    ],
                  );
                },
              ),
      ],
    );
  }

  _buildNotificationsRow(
      {Webinar data, bool isExpanded, BuildContext context}) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 16),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: kYellowColor,
            child: SvgPicture.asset(
              "assets/ic-logo.svg",
              color: kBlackColor,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Richadvert - сегодня, 12:15",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .apply(fontSizeDelta: -2),
              ),
              Text(
                getTranslated(context, "Вы записаны на вебинар") +
                    " ${data.date}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        );
      },
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              data.name,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return ChangeNotifierProvider<Webinar>.value(
                        value: data,
                        builder: (context, _) => WebinarDetailsScreen(),
                      );
                    }));
                  },
                  child: Text(
                    getTranslated(context, "К ТРАНСЛЯЦИИ"),
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )),
            ),
          ),
        ],
      ),
      isExpanded: isExpanded,
    );
  }
}

class NotificationRow {
  NotificationRow({
    this.webinar,
    // this.expandedValue,
    // this.headerValue,
    // this.sender,
    this.isExpanded = false,
  });
  Webinar webinar;
  // String expandedValue;
  // String headerValue;
  // String sender;
  bool isExpanded;
}
