class Constants {
  static const String apiProtocol = String.fromEnvironment(
    'API_PROTOCOL',
    defaultValue: 'http',
  );
  static const String apiHost = String.fromEnvironment(
    'API_HOST',
    defaultValue: '10.0.2.2',
  );
  static const String apiWebHost = String.fromEnvironment(
    'API_HOST',
    defaultValue: 'localhost',
  );
  static const String apiPort = String.fromEnvironment(
    'API_PORT',
    defaultValue: '3000',
  );
  static const String apiBaseURL = '$apiProtocol://$apiHost:$apiPort';
  static const String apiWebURL = '$apiProtocol://$apiWebHost:$apiPort';
}
