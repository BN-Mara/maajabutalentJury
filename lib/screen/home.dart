
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/screen/dashboad.dart';
import 'package:maajabu/util/themedata.dart';
import 'package:maajabu/util/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MaajabuAppTheme.black,
      appBar: AppBar(
        leading: Icon(Icons.home, color: MaajabuAppTheme.goldLight),
        title: appbarTitle("Home"),
        backgroundColor: MaajabuAppTheme.black,
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
          
          
          child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
            Card(
              color: MaajabuAppTheme.goldLight.withOpacity(0.9),
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(10.0),
                height: 300.0,
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Text("Choisissez le candidat sur la list, donnez le cote qu il merite",style: TextStyle(color: MaajabuAppTheme.black),),
                    SizedBox(height: 20.0),
                    Text("Verifier bien le resultat avant d'envoyer ...", style: TextStyle(color: MaajabuAppTheme.black,),textAlign: TextAlign.left,),
                  ],
                ),
              )
            ),
            SizedBox(height: 20.0),
            baseButton("Voir list de candicats", (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DashBoard()
              )
              );
            }, color: MaajabuAppTheme.goldDark, textColor: MaajabuAppTheme.black ),
          ],
        ),

      ),
      )
    );
  }
}
