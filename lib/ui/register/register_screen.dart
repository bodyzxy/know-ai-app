import 'package:flutter/cupertino.dart';
import 'package:know_ai_app/component/background.dart';
import 'package:know_ai_app/ui/register/register_form.dart';
import 'package:know_ai_app/ui/register/register_top_image.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RegisterScreenTopImage(),
            Row(
              children: [
                Spacer(),
                Expanded(
                  flex: 8,
                  child: RegisterForm(),
                ),
                Spacer(),
              ],
            ),
            // const SocalSignUp()
          ],
        )
      ),
    );
  }
}
