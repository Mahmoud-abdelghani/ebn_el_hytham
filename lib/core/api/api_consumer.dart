abstract class ApiConsumer {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path, {Object? body, Map<String, dynamic>? queryParameters});
  Future<dynamic> put(String path, {Object? body, Map<String, dynamic>? queryParameters});
  Future<dynamic> delete(String path, {Object? body, Map<String, dynamic>? queryParameters});
}
