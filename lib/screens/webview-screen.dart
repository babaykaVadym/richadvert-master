import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../screens/lesson-screen.dart';

class WebViewScreen extends StatelessWidget {
  final AdditionalMaterialsModel material;
  WebViewScreen(this.material);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(material.name),
      ),
      body: SafeArea(
        bottom: false,
        child: WebView(
            initialUrl: material.url,
            javascriptMode: JavascriptMode.unrestricted),
      ),
    );
  }
}
