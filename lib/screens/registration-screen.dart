import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/screens/home-page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatelessWidget {
  static String routeName = "registration";

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _isRegistered;

  Future<void> _setRegistrationStatus(String username, String email) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("username", username);
    prefs.setString("email", email);
    _isRegistered = prefs.setBool("isRegistered", true).then((bool success) {
      return _isRegistered;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(primarySwatch: Colors.orange),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                /// Top yellow circle
                top: -10,
                left: 36,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.45,
                  width: MediaQuery.of(context).size.height / 4.45,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height / 4.45),
                    color: kYellowColor,
                  ),
                ),
              ),
              Positioned(
                ///Bottom Big Circle
                bottom: -10,
                left: -200,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.23,
                  width: MediaQuery.of(context).size.height / 2.23,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height / 2.23),
                    gradient: new LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [kYellowColor, kOrangeColor],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 17.7,
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 2, color: Colors.white),
                          color: Colors.white54,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  getTranslated(context, "Регистрация"),
                                  style: TextStyle(
                                    color: kBlackColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  getTranslated(context, "Введите свои данные"),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: getTranslated(context, "Имя"),
                                    contentPadding: EdgeInsets.all(16),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kDarkGreyColor, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kOrangeColor, width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kOrangeColor, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kDarkGreyColor, width: 2.0),
                                    ),
                                  ),
                                  cursorColor: kBlackColor,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    hintText: getTranslated(
                                        context, "Электронная почта"),
                                    contentPadding: EdgeInsets.all(16),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kDarkGreyColor, width: 2.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kOrangeColor, width: 2.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kOrangeColor, width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                          color: kDarkGreyColor, width: 2.0),
                                    ),
                                  ),
                                  cursorColor: kBlackColor,
                                  style: Theme.of(context).textTheme.subtitle1,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '';
                                    } else {
                                      var splittedValue = value.split("@");
                                      if (splittedValue.length == 2) {
                                        if (splittedValue[1].contains("."))
                                          return null;
                                      }
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(27),
                                  child: Container(
                                    height: 54,
                                    width: 263,
                                    color: kOrangeColor,
                                    child: FlatButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _setRegistrationStatus(
                                                  usernameController.text,
                                                  emailController.text)
                                              .then((value) =>
                                                  Navigator.of(context)
                                                      .pushNamedAndRemoveUntil(
                                                          HomePage.routeName,
                                                          (route) => false));
                                        }
                                      },
                                      child: Text(
                                        getTranslated(
                                            context, "Зарегистрироваться"),
                                        style: TextStyle(
                                          color: kWhiteColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
