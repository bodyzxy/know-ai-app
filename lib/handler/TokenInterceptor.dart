import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:know_ai_app/config/request.dart';

class CustomInterceptor extends Interceptor {

  var requestPath = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    requestPath = options.path;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 使用refreshToken刷新accessToken结果响应403 说明refreshToken失效 需要重新登录
    if(err.response!.statusCode == 403 && requestPath == ApiUrl.refreshToken){
      Get.toNamed("/");
      return;
    }

  }

}