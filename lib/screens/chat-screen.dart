import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';

class ChatScreen extends StatelessWidget {
  static appBar(context) => AppBar(
        title: Text(getTranslated(context, "Чат")),
      );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Text(
                getTranslated(context, "Поддержка Richadvert"),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.caption,
              )),
          _buildRow(
              context: context,
              asset: "assets/ic-telegram.svg",
              title: getTranslated(context, "Написать в Telegram"),
              onTap: () {
                print("Telegram");
                _launchURL(kTelegramContact);
              }),
          _buildRow(
              context: context,
              asset: "assets/ic-skype.svg",
              title: getTranslated(context, "Написать в Skype"),
              onTap: () {
                launch(kSkypeContact);
              }),
        ],
      ),
    );
  }

  Future _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (url == kSkypeContact) {
        if (Platform.isIOS)
          await launch(
              "https://apps.apple.com/ua/app/skype-for-iphone/id304878510");
        else if (Platform.isAndroid)
          await launch("market://details?id=com.skype.raider");
      } else if (url == kTelegramContact) {
        if (Platform.isIOS)
          await launch(
              "https://apps.apple.com/ua/app/telegram-messenger/id686449807");
        else if (Platform.isAndroid)
          await launch("market://details?id=com.skype.raider");
      }
    }
  }

  Widget _buildRow(
      {String title, String asset, Function onTap, BuildContext context}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Card(
        elevation: 2.0,
        child: InkWell(
          onTap: onTap,
          child: AspectRatio(
            aspectRatio: 4.1,
            child: Container(
              height: 56,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  SizedBox(
                      height: 32, width: 32, child: SvgPicture.asset(asset)),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
