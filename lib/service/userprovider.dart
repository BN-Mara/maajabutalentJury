

import 'package:flutter/cupertino.dart';
import 'package:maajabu/model/appuser.dart';

class UserProvider with ChangeNotifier{
  AppUser _user = new AppUser();
  AppUser get user => _user;
  void setUser(AppUser user) {
    _user = user;
    notifyListeners();
  }
}