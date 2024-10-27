import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {

  // get base url from env file
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

}