import 'package:flutter/foundation.dart';

class Webinar extends ChangeNotifier {
  String id;
  String name;
  String description;
  String date;
  String speaker;
  String link;
  bool isJoined;

  void toggleJoined() {
    this.isJoined = !this.isJoined;
    notifyListeners();
  }

  Webinar(
      {this.id,
      this.name,
      this.description,
      this.date,
      this.speaker,
      this.isJoined = false,
      this.link});

  Webinar.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.description = json['description'];
    this.date = json['date'];
    this.speaker = json['speaker'];
    this.link = json['link'];
    this.isJoined = json['isJoined'] ?? false;
  }
}
