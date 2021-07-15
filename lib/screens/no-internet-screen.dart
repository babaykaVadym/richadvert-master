import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rich_advert_app/constants.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              bottom: 100,
              left: -150,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.height / 2.5,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height / 3.5),
                  color: kDarkGreyColor,
                ),
              ),
            ),
            Positioned(
              ///Bottom Big Circle
              bottom: -50,
              right: -150,
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
                          child: Text(
                            "Нет подключения к интернету",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1,
                          )),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
