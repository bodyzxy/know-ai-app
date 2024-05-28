import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:know_ai_app/constant.dart';
import 'package:know_ai_app/manager/asset_manager.dart';

class WelcomeImage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "WELCOME TO EDU",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                AssetManager.CHAT_ICONS,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}