class Constants {
  static const String baseUrl = 'http://passcash-api-hml.us-east-1.elasticbeanstalk.com';
  // static const String baseUrl = 'http://10.0.2.2:5000';
  static const _ApiEndpoints api = _ApiEndpoints();

  const Constants._();
}

class _ApiEndpoints {
  final String account = '${Constants.baseUrl}/api/Account';
  final String apiMaster = '${Constants.baseUrl}/api/ApiMaster';

  const _ApiEndpoints();
}