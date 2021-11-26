import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/model/appuser.dart';
import 'package:maajabu/service/userprovider.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  final AppUser user;

  Welcome({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context).setUser(user);

    return Scaffold(
      body: Container(
        child: Center(
          child: Text("WELCOME PAGE"),
        ),
      ),
    );
  }
}