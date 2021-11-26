import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/model/appuser.dart';
import 'package:maajabu/service/authservice.dart';
import 'package:maajabu/service/userprovider.dart';
import 'package:maajabu/util/validator.dart';
import 'package:maajabu/util/widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password, _confirmPassword, _phone, _firstname, _lastname, _address;


  @override
  Widget build(BuildContext context) {
    Authprovider auth = Provider.of<Authprovider>(context);



    final firstnameField = TextFormField(
      autofocus: false,
      validator: null,
      onSaved: (value) => _firstname = value,
      decoration: buildInputDecoration("Enter your firstname", Icons.supervised_user_circle),
    );
    final lastnameField = TextFormField(
      autofocus: false,
      validator: null,
      onSaved: (value) => _lastname = value,
      decoration: buildInputDecoration("Enter your lastname", Icons.supervised_user_circle),
    );
    final addressField = TextFormField(
      autofocus: false,
      validator: null,
      onSaved: (value) => _address = value,
      decoration: buildInputDecoration("Enter your address", Icons.location_pin),
    );
    final phoneField = TextFormField(
      autofocus: false,
      validator: null,
      onSaved: (value) => _phone = value,
      decoration: buildInputDecoration("Enter your phone number", Icons.phone),
    );
    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(

          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
          },
        ),
        TextButton(

          child: Text("Sign in", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );

    var doRegister = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.register(_firstname,_lastname,_address,_phone,_username, _password,).then((response) {
          if (response['status']) {
            AppUser user = response['data'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Registration Failed",
              message: response.toString(),
              duration: Duration(seconds: 10),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please Complete the form properly",
          duration: Duration(seconds: 10),
        ).show(context);
      }

    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.app_registration),
          title: Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label("First name"),
                  SizedBox(height: 5.0),
                  firstnameField,
                  SizedBox(height: 10.0),
                  label("Last name"),
                  SizedBox(height: 5.0),
                  lastnameField,
                  SizedBox(height: 10.0),
                  label("Address"),
                  SizedBox(height: 5.0),
                  addressField,
                  SizedBox(height: 10.0),
                  label("Phone"),
                  SizedBox(height: 5.0),
                  phoneField,
                  label("Email"),
                  SizedBox(height: 5.0),
                  usernameField,
                  SizedBox(height: 15.0),
                  label("Password"),
                  SizedBox(height: 10.0),
                  passwordField,
                  SizedBox(height: 15.0),
                  label("Confirm Password"),
                  SizedBox(height: 10.0),
                  confirmPassword,
                  SizedBox(height: 20.0),
                  auth.registeredInStatus == Status.REGISTERING
                      ? loading
                      : longButtons("Register", doRegister),
                  SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}