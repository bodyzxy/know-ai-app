import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:know_ai_app/api/token_refresh.dart';
import 'package:know_ai_app/controller/draw_controller.dart';
import 'package:know_ai_app/controller/token_controller.dart';
import 'package:know_ai_app/manager/localization.dart';
import 'package:know_ai_app/model/hive_box.dart';
import 'package:know_ai_app/model/message.dart';
import 'package:know_ai_app/storage/token_storage.dart';

import 'config/router.dart';
import 'constant/constant.dart';
import 'controller/chat.dart';
import 'controller/user_controller.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<HistoryMessage>(historyBox);
  await Hive.openBox<Message>(settingBox);
  await init();

  String initPath = await getInitRoute();

  runApp(MyApp(
    initPath: initPath,
  ));
}

Future<void> init() async {
  Get.lazyPut(() => ChatPageController());
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => TokenController());
  Get.lazyPut(() => DrawController());
}

Future<String> getInitRoute() async {
  var userController = Get.find<UserController>();
  var tokenController = Get.find<TokenController>();
  var tokenStorage = TokenStorage();
  var tokenApi = TokenAPi();

  await tokenStorage.deleteAllTokens();

  // 1. 判断本地accessToken是否存在
  String accessToken = await tokenStorage.getAccessToken();
  // 如果本地没有存储accessToken 则说明首次登录
  if (accessToken.isEmpty) {
    return "/";
  } else {
    // 2. 如果存在，使用accessToken请求用户信息
    var user = await userController.getUserInformation();
    if (user.name.isEmpty) {
      // todo: 4. 请求失败 使用refreshToken请求新的accessToken
      // 获取新的accessToken 如果响应403 会自动跳转到“/”路由 因此不需要在这里做判断
      String accessToken = await tokenApi.getAccessToken();
      tokenStorage.setAccessToken(accessToken);
      // todo: 5. 请求成功 重置accessToken 返回"/home"
      user = await userController.getUserInformation();
      return "/home";
    }
    // todo: 3. 请求成功 返回 "/home"
    return "/home";
  }
}

class MyApp extends StatelessWidget {
  late String initPath;

  MyApp({super.key, required this.initPath});

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
      initialRoute: initPath,
      getPages: Routers.routes,
      // home: const DrawPage(),
    );
  }
}
