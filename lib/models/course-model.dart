import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/models/lesson-model.dart';

class Course with DiagnosticableTreeMixin {
  int id;
  String name;
  String description;
  List<Lesson> lessons;
  Course({
    @required this.id,
    @required this.name,
    @required this.description,
  }) {
    fetchLessons(id).then((value) => this.lessons = value);
  }

  Course.fromJson(Map<String, dynamic> json) {
    this.id = int.parse(json['id']);
    this.name = json['name'];
    this.description = json['description'];
    fetchLessons(id).then((value) => this.lessons = value);
  }
  Future<List<Lesson>> fetchLessons(int id) async {
    var url =
        'https://dev.richadvert.ru/services/richadvertapp/getData.php?query=getLessons&course_id=$id&api_key=$kApiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var data = List<Lesson>();
      await jsonResponse.forEach((webinarJson) {
        data.add(Lesson.fromJson(webinarJson));
      });
      return data;
    } else {
      throw ('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('lessons', lessons));
  }
}
