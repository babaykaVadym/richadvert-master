import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/screens/webview-screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebinarDetailsScreen extends StatelessWidget {
  static String routeName = "/webinar";
  @override
  Widget build(BuildContext context) {
    var webinar = Provider.of<Webinar>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Трансляция вебинара")),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
                initialUrl: webinar.link,
                javascriptMode: JavascriptMode.unrestricted),
          ),
        ),
      ),
    );
  }
}
