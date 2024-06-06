import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:know_ai_app/manager/localization.dart';
import 'package:know_ai_app/model/hive_box.dart';
import 'package:know_ai_app/model/message.dart';
import 'package:know_ai_app/model/response/message.g.dart';
import 'package:know_ai_app/config/router/router.dart';

import 'constant/constant.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Message>(MessageAdapter());
  Hive.registerAdapter<HistoryMessage>(HistoryMessageAdapter());
  await Hive.openBox<HistoryMessage>(historyBox);
  await Hive.openBox<Message>(settingBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      translations: Localization(),
      locale: const Locale('zh'),
      initialRoute: "/",
      getPages: Routers.routes,
      // home: const UserSetting(),
    );
  }
}
