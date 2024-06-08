import 'package:dio/dio.dart';

import '../handler/TokenInterceptor.dart';

class CustomizeDio {
  static const BASE_URL = "http://45.32.33.60:8818";

  // 私有的命名构造函数
  CustomizeDio._internal();

  // 静态变量保存唯一的实例
  static final CustomizeDio _instance = CustomizeDio._internal();

  // 静态方法返回唯一的实例
  static CustomizeDio get instance => _instance;


  Dio getDio({token=""}) {
    var dio = Dio();
    dio.options.baseUrl = BASE_URL;
    dio.options.headers = {
      'Content-Type': 'application/json;Charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    dio.interceptors.add(CustomInterceptor());
;    return dio;
  }
}

class ApiUrl {
  static const chat = "/api/v1/chat/stream";
  static const register = "/api/v1/account/register";
  static const login = "/api/v1/account/login";
  static const emailVerify = "/api/v1/account/verify";
  static const userInfo = "/api/v1/account/info";
  static const logout = "/api/v1/account/logout";
  static const refreshToken = "/api/v1/account/refresh-token";
  static const draw = "/api/v1/draw/";
  static const upload = "/api/v1/know/file/upload";
  static const deleteFile = "/api/v1/know/contents";
}