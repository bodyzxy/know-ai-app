import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:know_ai_app/config/request.dart';

class CustomInterceptor extends Interceptor {

  var requestPath = "";

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    requestPath = options.path;
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 使用refreshToken刷新accessToken结果响应403 说明refreshToken失效 需要重新登录
    if(err.response!.statusCode == 403 && requestPath == ApiUrl.refreshToken){
      g.Get.toNamed("/");
      return;
    }
    
    handler.next(err);

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}