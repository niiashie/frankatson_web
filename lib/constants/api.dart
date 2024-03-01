class Api {
  static const int connectionTimeout = 35;
  static const int receiveTimeout = 20;
  static String baseUrl = "http://frankowebbackend.test/api";
  static String dataUrl = "http://frankowebbackend.test";
  static const auth = "/auth";
  static const login = "$auth/login";
  static const register = '$auth/register';
  static const news = "/news";
  static const deleteNews = "/deleteNews";
  static const String gallery = "/gallery";
  static const String deleteGallery = '/deleteGallery';
  static const String blogCategories = '/blogCategories';
  static const String document = '/document';
}
