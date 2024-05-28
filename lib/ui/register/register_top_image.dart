import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/utils.dart';
import 'package:know_ai_app/constant.dart';
import 'package:know_ai_app/manager/asset_manager.dart';

class RegisterScreenTopImage extends StatelessWidget {
  const RegisterScreenTopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          // "Sign Up".toUpperCase(),
          'signUpButton'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(AssetManager.SIGNUP_ICONS),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
