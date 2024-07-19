import 'package:passaqui/src/core/constants.dart';

class AppConfig {
  static const String baseUrl = Constants.baseUrl;
  static const ApiEndpoints api = ApiEndpoints();

  const AppConfig._();
}

class ApiEndpoints {
  final String account = '${AppConfig.baseUrl}/api/Account';
  final String apiMaster = '${AppConfig.baseUrl}/api/ApiMaster';

  const ApiEndpoints();
}