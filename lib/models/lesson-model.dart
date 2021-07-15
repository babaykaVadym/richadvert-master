import 'package:flutter/foundation.dart';

class Lesson extends ChangeNotifier {
  String id;
  String name;
  String description;
  String link;
  String courseId;
  String blockId;
  String html;
  bool isFavorite;
  int index;

  Lesson(
      {this.id,
      this.name,
      this.description,
      this.link,
      this.courseId,
      this.blockId,
      this.index});

  void toggleFavorite() {
    this.isFavorite = !this.isFavorite;
    notifyListeners();
  }

  Lesson.fromJson(Map<String, dynamic> json) {
    var temp = json["name"].split(".");

    this.isFavorite = false;
    this.id = json['id'];
    this.name = json["name"];
    this.description = temp[1];
    this.html = json['description'];
    this.link = json['link'];
    this.courseId = json['course_id'];
    this.blockId = json['block_id'];
    this.index = json['index'];
  }
}
