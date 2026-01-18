class ApiUrl {
  static String baseUrl = "http://127.0.0.1:8000";
  // static String baseUrl = 'http://localhost:8000';
  // static String baseUrl = 'http://10.0.2.2:8000';

  static String login = '/auth/login';
  static String register = '/auth/register';
  static String validateToken = '/auth/validate';
  static String logout = '/auth/logout';

  static String products = '/products/';
  static String categories = '/categories/';
}
