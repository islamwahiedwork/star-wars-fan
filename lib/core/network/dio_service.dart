import 'package:dio/dio.dart';
import 'package:star_wars_app/core/utils/app_constance.dart';

class DioService {
  late Dio _dio;
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstance.baseUrl, // Replace with your base URL
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Adding interceptors if needed
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        return handler.next(e); // continue
      },
    ));
  }

  Future<Response> getRequest({required String path, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
