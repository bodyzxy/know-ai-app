import 'package:flutter/material.dart';
import 'package:know_ai_app/component/background.dart';
import 'package:know_ai_app/ui/welcome/welcome_bk_image.dart';
import 'package:know_ai_app/ui/welcome/welcome_btns.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Background(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              WelcomeImage(),
              const Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 8,
                    child: LoginAndSignupBtn(),
                  ),
                  Spacer(),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}