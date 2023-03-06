import 'package:dio/dio.dart';
class ApiKeyInterceptor extends Interceptor{
  final String _apiKey;
  const ApiKeyInterceptor(this._apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters["api_key"] = _apiKey;
    print("ApiKeyInterceptor: query: ${options.uri.toString()}");
    return handler.next(options);
  }
}