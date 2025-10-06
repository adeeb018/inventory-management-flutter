class AppConstants {
  // for testing with backend
  static const String baseUrl = 'http://13.127.33.167:3000';
  // for testing locally
  // static const String baseUrl = 'http://100.31.1.211:3000';
  // static const String baseUrl = 'http://192.168.1.109:3000';

  static const String loginUrl = '/auth/login';
  static const String refreshTokenUrl = '/auth/refresh';

  static String getPartReportUrl(int projectId) {
    return '/projects/$projectId/part-report';
  }

  static const String getProjectsUrl = '/projects';

  static const String getPartsUrl = '/parts';
  static const String addParts = '/parts';

  static String getPartDetailsUrl(String partNumber) {
    return '/parts/details/$partNumber';
  }

  static String getPartDataUrl(String partNumber) {
    return '/parts/search?part_number=$partNumber';
  }
}
