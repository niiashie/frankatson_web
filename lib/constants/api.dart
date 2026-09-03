class Api {
  static const int connectionTimeout = 35;
  static const int receiveTimeout = 20;
  static String baseUrl =
      "https://api.frankatsongh.com/api"; //"https://webapi.com.frankatsongh.com/api";
  static String dataUrl = "https://api.frankatsongh.com/";
  // "https://webapi.com.frankatsongh.com"; //https://webapi.com.frankatsongh.com
  static const auth = "/auth";
  static const login = "$auth/login";
  static const register = '$auth/register';
  static const posts = "/news";
  static const deletePost = "/deleteNews";
  static const String gallery = "/gallery";
  static const String deleteGallery = '/deleteGallery';
  static const String blogCategories = '/blogCategories';
  static const String document = '/document';
  static const String postComments = '/postComments';
  static const String postLikes = '/postLikes';
}
