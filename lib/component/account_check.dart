import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:know_ai_app/constant.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;

  const AlreadyHaveAnAccountCheck(
      {super.key, this.login = true, required this.press});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? 'not.account'.tr : 'have.account'.tr,
          style: const TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: Text(
            login ? 'signUpButton'.tr : 'signInButton'.tr,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
