import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/models/webinar-model.dart';

class WebinarsState with ChangeNotifier, DiagnosticableTreeMixin {
  List<Webinar> _webinars = List<Webinar>();
  List<Webinar> get webinars => _webinars;
  List<Webinar> get joinedWebinars =>
      _webinars.where((element) => element.isJoined).toList();

  void loadData() {
    this.fetch().then((value) {
      this._webinars = value;
      notifyListeners();
    }).catchError((error) {
      ///Todo crash analytics
    });
  }

  List<Webinar> get timetable {
    var temp = List<Webinar>();

    _webinars.forEach((webinar) {
      if (DateTime.parse(webinar.date).compareTo(DateTime.now()) < 0) {
        temp.add(webinar);
      }
    });
    return temp;
  }

  void toggleJoinWebinar(Webinar webinar) {
    _webinars[_webinars.indexOf(webinar)].toggleJoined();

    notifyListeners();
  }

  Future<List<Webinar>> fetch() async {
    var url =
        'https://dev.richadvert.ru/services/richadvertapp/getData.php?query=getWebinars&api_key=' +
            kApiKey;

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var data = List<Webinar>();
      await jsonResponse.forEach((webinarJson) {
        data.add(Webinar.fromJson(webinarJson));
      });
      return data;
    } else {
      throw ('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('webinars', _webinars));
  }
}
