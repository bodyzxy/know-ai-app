import 'package:dio/dio.dart';
import 'package:know_ai_app/model/response/base_response.dart';
import 'package:know_ai_app/handler/interceptor/custom_interceptor.dart';
import 'package:know_ai_app/constant/http_method.dart';

class NetworkManager {
  // 移除单例模式，直接创建实例
  NetworkManager();

  final _mBaseUrl = "http://45.32.33.60:8818";
  late Dio _dio;

  // 初始化方法，用于配置 Dio 实例
  void initialize() {
    BaseOptions options = BaseOptions(
      baseUrl: _mBaseUrl,
      connectTimeout: const Duration(seconds: 150),
      receiveTimeout: const Duration(seconds: 100),
      // 将 contentType 配置为 headers 的一部分
      headers: {
        'Content-Type': 'application/json;Charset=UTF-8',
      },
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    // 添加日志拦截器
    _dio.interceptors.add(CustomInterceptor());
  }

  // 网络请求
  Future<BaseResponse<dynamic>> request<T>(String path,
      {required HttpMethod method,
      Map<String, dynamic>? params,
      data,
      Options? options}) async {
    const methodValue = {
      HttpMethod.get: 'get',
      HttpMethod.post: 'post',
      HttpMethod.delete: 'delete',
      HttpMethod.put: 'put',
      HttpMethod.patch: 'patch',
      HttpMethod.head: 'head'
    };
    options ??= Options(method: methodValue[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data, queryParameters: params, options: options);
      return BaseResponse<dynamic>(
        code: response.statusCode,
        message: response.statusMessage,
        data: response.data,
      );
    } on DioException catch (e) {
      // 使用 throw 关键字抛出新的异常，携带原始异常信息
      throw (message: e.message, error: e.error);
    }
  }
}
