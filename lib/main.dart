import 'package:flutter/material.dart';
import 'package:maajabu/screen/dashboad.dart';
import 'package:maajabu/screen/login.dart';
import 'package:maajabu/screen/register.dart';
import 'package:maajabu/screen/welcome.dart';
import 'package:maajabu/service/authservice.dart';
import 'package:maajabu/service/userprovider.dart';
import 'package:provider/provider.dart';

import 'data/user_preference.dart';
import 'model/appuser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<AppUser> getUserData() => UserPreference().getUser();
    /*return MaterialApp(
      title: 'maajabu jury',
      home:Login()
    );*/

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Authprovider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          title: 'MaajabuTalent Jury',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data.token == null)
                      return Login();
                    else
                      UserPreference().removeUser();
                    return Welcome(user: snapshot.data);
                }
              }),
          routes: {
            '/dashboard': (context) => DashBoard(),
            '/login': (context) => Login(),
            '/register': (context) => Register(),
          }),
    );
  }
}