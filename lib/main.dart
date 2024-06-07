import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:know_ai_app/manager/localization.dart';
import 'package:know_ai_app/model/hive_box.dart';
import 'package:know_ai_app/model/message.dart';
import 'package:know_ai_app/storage/token_storage.dart';

import 'config/router/router.dart';
import 'constant/constant.dart';
import 'controller/chat.dart';

void main() async {
  await Hive.initFlutter();
  // Hive.registerAdapter<Message>(MessageAdapter());
  // Hive.registerAdapter<HistoryMessage>(HistoryMessageAdapter());
  await Hive.openBox<HistoryMessage>(historyBox);
  await Hive.openBox<Message>(settingBox);

  String initPath = await getInitRoute();

  runApp(MyApp(initPath: initPath,));
}


Future<String> getInitRoute() async {

  // todo: 1. 判断本地accessToken是否存在
  String token = await TokenStorage().getAccessToken();
  // 如果本地没有存储accessToken 则说明首次登录
  if(token.isEmpty){
    return "/";
  }
  // todo: 2. 如果存在，使用accessToken请求用户信息
  return "/home";
  // todo: 3. 请求成功 返回 "/home"

  // todo: 4. 请求失败 使用refreshToken请求新的accessToken

  // todo: 5. 请求成功 重置accessToken 返回"/home"

  // todo: 6. 请求失败 返回"/"
}




class MyApp extends StatelessWidget {

  late String initPath;

  MyApp({super.key, required this.initPath});

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => ChatPageController());

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
      initialRoute: initPath,
      getPages: Routers.routes,
      // home: const DrawPage(),
    );
  }

}
