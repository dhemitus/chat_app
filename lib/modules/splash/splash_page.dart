import 'package:flutter/material.dart';
import 'package:chatapp/theme/theme.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 240,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/adira_logo_white.png'),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 72),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "CATS",
                      style: blackTextStyle.copyWith(
                        fontWeight: bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Collection Activity and Tracking System",
                      style: blackTextStyle.copyWith(
                        fontWeight: light,
                      ),
                    ),
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
