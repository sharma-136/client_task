import 'package:assignment/data/sources/remote/api_client.dart';

class MovieRepository {
  Future<dynamic> movies(dynamic q) async {
    try {
      final response = ApiClient.client.get('', query: q);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
