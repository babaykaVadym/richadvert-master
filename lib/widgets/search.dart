import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';
import 'package:rich_advert_app/screens/webinar-details-screen.dart';
import 'package:rich_advert_app/utils/custom-route-transition.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(child: Text("$selectedResult")),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList.addAll(listExample.where(
            (element) => element.contains(query),
          ));
    var webinarState = Provider.of<WebinarsState>(context, listen: false);

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        var webinar = webinarState.webinars.where(
            (element) => element.name.toLowerCase() == suggestionList[index]);
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            Navigator.of(context).popUntil((r) => r.isFirst);
            Navigator.push(
              context,
              FadePageRoute(
                ChangeNotifierProvider<Webinar>.value(
                  value: webinar.first,
                  builder: (context, _) => WebinarDetailsScreen(),
                ),
              ),
            );
            // showResults(context);
          },
        );
      },
    );
  }
}
