class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://192.168.43.199/maajabu/public/api";
  //static const String coteBaseURL = "http://192.168.43.199/maajabu/public/api/votejury";

  static const String baseURL = localBaseURL;
  static Uri login = Uri.parse(baseURL+"/login");
  //static const String register = baseURL + "/register";
  static Uri register = Uri.parse(baseURL+"/register");
  //static const String forgotPassword = baseURL + "/forgot-password";
  static Uri forgotPassword = Uri.parse(baseURL+"/forgot-password");
  static Uri cotation = Uri.parse(baseURL+"/cotation");
}