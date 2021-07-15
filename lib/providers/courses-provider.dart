import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/models/course-model.dart';
import 'package:rich_advert_app/models/lesson-model.dart';

class CoursesState with ChangeNotifier, DiagnosticableTreeMixin {
  List<Course> _courses = List<Course>();
  List<Course> get courses => _courses;

  List<Lesson> get _lessons {
    var result = List<Lesson>();
    courses.forEach((course) {
      course.lessons.forEach((lesson) {
        result.add(lesson);
      });
    });
    return result;
  }

  List<Lesson> get favoritesLessons {
    var result = List<Lesson>();
    courses.forEach((course) {
      course.lessons.forEach((lesson) {
        if (lesson.isFavorite) {
          result.add(lesson);
        }
      });
    });
    return result;
  }

  void toggleLessonFavoriteState(Lesson lesson) {
    _lessons[_lessons.indexOf(lesson)].toggleFavorite();

    notifyListeners();
  }

  void loadData() {
    this.fetch().then((value) {
      this._courses = value;
      notifyListeners();
    }).catchError((error) {
      ///Todo crash analytics
    });
  }

  Future<List<Course>> fetch() async {
    var url =
        'https://dev.richadvert.ru/services/richadvertapp/getData.php?query=getCourses&api_key=$kApiKey';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var data = List<Course>();

      await jsonResponse.forEach((courseJson) {
        data.add(Course.fromJson(courseJson));
      });
      return data;
    } else {
      throw ('Request failed with status: ${response.statusCode}.');
    }
    // notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('courses', _courses));
  }
}
