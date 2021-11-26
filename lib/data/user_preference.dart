
import 'package:maajabu/model/appuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(AppUser user) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("userId", user.userId);
    prefs.setString("firstname", user.firstname);
    prefs.setString("lastname", user.lastname);
    prefs.setString("email", user.email);
    prefs.setString("phone", user.phone);
    prefs.setString("address", user.address);
    prefs.setString("token", user.token);
    prefs.setString("renewalToken", user.renewalToken);

    // ignore: deprecated_member_use
    return prefs.commit();

  }
  Future<AppUser> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    String firstname = prefs.getString("firstname");
    String lastname = prefs.getString("lastname");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String address = prefs.getString("address");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return AppUser(
        userId: userId,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        address: address,
        token: token,
        renewalToken: renewalToken);
  }
  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("firstname");
    prefs.remove("lastname");
    prefs.remove("address");
    prefs.remove("email");
    prefs.remove("phone");
    prefs.remove("renewalToken");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}