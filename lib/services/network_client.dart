import 'package:dio/dio.dart';
import 'package:emp_agreement/errors/exceptions.dart';

class NetworkClient {
  Dio _dio = Dio();
  NetworkClient({String? baseUrl}) {
    baseUrl ??= "https://employmentagreement.dc.com.pk";
    BaseOptions baseOptions = BaseOptions(
        receiveTimeout: const Duration(milliseconds: 20000),
        connectTimeout: const Duration(milliseconds: 30000),
        baseUrl: baseUrl,
        maxRedirects: 2);

    _dio = Dio(baseOptions);
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      error: true,
      request: false,
      requestHeader: false,
      responseBody: true,
      responseHeader: false,
    ));
  }

  /// for Http.Get requests
  Future<Response> get(String url,
      {Map<String, dynamic>? params, String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) map.addAll({"Authorization": "Bearer $token"});

      response = await _dio.get(url,
          queryParameters: params,
          options: Options(
            headers: map,
          ));
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
    return response;
  }

  // for Http.Post Request.
  Future<Response> post(String url, Map<String, dynamic> params,
      {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) {
        map.addAll({"Authorization": "Bearer $token"});
      }
      response = await _dio.post(url,
          data: params,
          options: Options(
            headers: map,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ));
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
    return response;
  }

  // for Http.Put Request.
  Future<Response> put(String url, Map<String, dynamic> params,
      {String? token}) async {
    Response response;
    try {
      Map<String, dynamic> map = {"Accept": "application/json"};
      if (token != null) {
        map.addAll({"Authorization": "Bearer $token"});
      }
      response = await _dio.put(url,
          data: params,
          options: Options(
            headers: map,
            responseType: ResponseType.json,
            validateStatus: (_) => true,
          ));
    } on DioException catch (exception) {
      throw RemoteException(dioException: exception);
    }
    return response;
  }
}
