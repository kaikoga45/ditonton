import 'package:http/http.dart' as http;

import 'override_http.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _client ??= await HttpOverride.createLEClient();

  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<void> init() async {
    _client = await _instance;
  }
}
