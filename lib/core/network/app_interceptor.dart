import 'dart:convert';

import 'package:dio/dio.dart';
import '../storage/app_storage.dart';
import 'api_config.dart';

class AppInterceptor extends Interceptor {

  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String token = await AppStorage.getAuthTokenVal();
    if (token.isNotEmpty) {
      options.headers.addAll({"Authorization":  'Bearer $token'});
    }else{
      String basicAuth = 'Basic ${base64Encode(utf8.encode('${ApiConfig.clientId}:${ApiConfig.apiKey}'))}';
      options.headers.addAll({"Authorization":  basicAuth});
    }
    
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    }
    else if (response.statusCode == 401) {
      // log the user out if token is no longer valid

    }
    return super.onResponse(response, handler);
  }
}
