import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';
import 'package:rich_advert_app/screens/home-page.dart';
import 'package:rich_advert_app/screens/no-internet-screen.dart';
import 'package:rich_advert_app/screens/registration-screen.dart';
import 'package:rich_advert_app/utils/custom-route-transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "splash";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    bool isInternetAvalibe = true;
    _checkInternetAvailability().then((value) {}).catchError((_) {
      isInternetAvalibe = false;
    });
    _fetchData(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      _getRegistrationStatus().then((isRegistered) {
        if (!isInternetAvalibe) {
          Navigator.pushAndRemoveUntil(
              context, FadePageRoute(NoInternetScreen()), (route) => false);
        } else if (isRegistered) {
          Navigator.pushAndRemoveUntil(
              context, FadePageRoute(HomePage()), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context, FadePageRoute(RegistrationScreen()), (route) => false);
        }
      }).catchError((printError) {
        ///TODO implement crash analytics
        print(printError);
      });
    });
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -20,
              left: -100,
              child: Row(
                children: [
                  SizedBox(
                      height: 1,
                      width: 1,
                      child: SvgPicture.asset("assets/ic-skype.svg")),
                  SvgPicture.asset("assets/ic-telegram.svg"),
                  SvgPicture.asset("assets/ic-viber.svg"),
                  SvgPicture.asset("assets/ic-whatsapp.svg"),
                ],
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * .3,
            left: 0,
            right: 0,
            child: Center(
              child: new Image.asset(
                'assets/registration-logo.png',
                width: MediaQuery.of(context).size.width * .5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Future<bool> _getRegistrationStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isRegistered') ?? false;
  }

  void _fetchData(context) {
    Provider.of<WebinarsState>(context, listen: false).loadData();
    Provider.of<CoursesState>(context, listen: false).loadData();
  }

  Future<bool> _checkInternetAvailability() async {
    final result = await InternetAddress.lookup('richadvert.ru');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      throw "No internet";
    }
  }
}
