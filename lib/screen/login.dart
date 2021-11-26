import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/model/appuser.dart';
import 'package:maajabu/screen/dashboad.dart';
import 'package:maajabu/screen/home.dart';
import 'package:maajabu/service/authservice.dart';
import 'package:maajabu/service/userprovider.dart';
import 'package:maajabu/util/themedata.dart';
import 'package:provider/provider.dart';
import 'package:maajabu/util/validator.dart';
import 'package:maajabu/util/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    Authprovider auth = Provider.of<Authprovider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter username" : null,//validateEmail,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("", Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(

          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(

          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            //Navigator.pushReplacementNamed(context, '/register');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoard()));
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        setState(() {
          this.isloading = true;
        });
        /*if(_username == "maajabu" && _password == "123456"){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()
          )
          );
        }else{
          setState(() {
            this.isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Incorrect credentials"),
              )
          );
        }*/

        final Future<Map<String, dynamic>> successfulMessage =
        auth.login(_username, _password);
        successfulMessage.then((response) {
          if (response['status']) {
            AppUser user = response['user'];
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
backgroundColor: MaajabuAppTheme.black,
        appBar: AppBar(
          leading: Icon(Icons.login, color: MaajabuAppTheme.goldLight,),
          title: appbarTitle("Login"),
          backgroundColor: MaajabuAppTheme.black,
          elevation: 25.0,
          

        ),

        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MaajabuAppTheme.black,
                  
                  MaajabuAppTheme.black,
                ],
              )
          ),

          child: SingleChildScrollView(
            padding: EdgeInsets.all(40.0),

            child: Column(
              children: <Widget>[
                Center(
                  child: Image.asset("assets/Maajabu-986x1024.png", width: 88.0, height: 91.0,),
                ),
                SizedBox(height: 50.0),
                Card(

                  color: Colors.white,

                  child:Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child:

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        label("Email"),
                        SizedBox(height: 5.0),
                        usernameField,
                        SizedBox(height: 20.0),
                        label("Password"),
                        SizedBox(height: 5.0),
                        passwordField,
                        SizedBox(height: 20.0),
                        //auth.loggedInStatus == Status.AUTHENTICATING
                      isloading
                            ? loading
                            : baseButton("Login", doLogin,color: MaajabuAppTheme.goldDark, textColor: MaajabuAppTheme.nearlyBlack),
                        SizedBox(height: 1.0),
                        //forgotLabel
                      ],
                    ),
                    ),
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}