import 'dart:io';

import 'package:html/parser.dart' show parse;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/lesson-model.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/screens/webview-screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonScreen extends StatefulWidget {
  static String routeName = "/lesson";
  final Lesson lesson;
  LessonScreen(this.lesson);
  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getUrl() {
    var doc = parse(widget.lesson.html);
    return doc.getElementsByTagName("iframe").first.attributes["src"];
  }

  List<AdditionalMaterialsModel> _parse() {
    var doc = parse(widget.lesson.html);
    var materials = List<AdditionalMaterialsModel>();
    doc.getElementsByTagName("p").forEach((element) {
      if (doc.getElementsByTagName("p").indexOf(element) == 0) return;
      var url = element.getElementsByTagName("a").first.attributes["href"];
      materials.add(
          new AdditionalMaterialsModel(name: element.text.trim(), url: url));
    });
    return materials;
  }

  @override
  Widget build(BuildContext context) {
    var coursesState = Provider.of<CoursesState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.name),
        actions: [
          IconButton(
              icon: Icon(
                widget.lesson.isFavorite ? Icons.star : Icons.star_outline,
                color: kBlackColor,
              ),
              onPressed: () {
                coursesState.toggleLessonFavoriteState(widget.lesson);
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: WebView(
                    initialUrl: _getUrl(),
                    javascriptMode: JavascriptMode.unrestricted),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.lesson.name,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Divider(),
                    SizedBox(
                      height: 8,
                    ),
                    Text(getTranslated(context, "Дополнительные материалы")),
                    SizedBox(
                      height: 8,
                    ),
                    ..._parse().map((element) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return WebViewScreen(element);
                                  }));
                        },
                        leading: Icon(
                          Icons.assignment,
                          color: kOrangeColor,
                        ),
                        title: Text(
                          element.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalMaterialsModel {
  String name;
  String url;
  AdditionalMaterialsModel({this.name, this.url});
}
