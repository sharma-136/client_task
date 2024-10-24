import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient _client = ApiClient._();

  static ApiClient get client => _client;

  final _dio = Dio();

  final String _baseUrl = 'https://www.omdbapi.com/';

  void init() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      queryParameters: {
        "apikey": "effb23d4",
      },
    );
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic> query = const {}}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return Future.error('Something went wrong');
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> _handleError(dynamic e) {
    if (e is SocketException) {
      return Future.error("Looks like you are not connected to internet");
    } else if (e is TimeoutException) {
      return Future.error("Look like server is not reachable");
    } else if (e is DioException) {
      switch (e.response?.statusCode) {
        case 500:
          return Future.error("Server not reachable at this moment.Please try after sometime.");
      }
      return Future.error(e.message ?? "Something went wrong.Please Try Again");
    }
    return Future.error("Something went wrong.Please Try Again");
  }
}
