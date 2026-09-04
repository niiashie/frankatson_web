class Api {
  static const int connectionTimeout = 35;
  static const int receiveTimeout = 20;
  static String baseUrl = "http://frankowebbackend.test/api";
  //"https://api.frankatsongh.com/api";
  static String dataUrl =
      "http://frankowebbackend.test/"; //"https://api.frankatsongh.com/";

  static const auth = "/auth";
  static const login = "$auth/login";
  static const register = '$auth/register';
  static const logout = '$auth/logout';
  static const logoutAll = '$auth/logout-all';
  static const me = '$auth/me';
  static const posts = "/news";
  static const deletePost = "/deleteNews";
  static const String gallery = "/gallery";
  static const String deleteGallery = '/deleteGallery';
  static const String blogCategories = '/blogCategories';
  static const String document = '/document';
  static const String postLikes = '/postLikes';
}
