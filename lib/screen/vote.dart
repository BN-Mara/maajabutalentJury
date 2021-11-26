
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/model/candidate.dart';
import 'package:maajabu/model/cotation.dart';
import 'package:maajabu/service/dataservice.dart';
import 'package:maajabu/util/themedata.dart';
import 'package:maajabu/util/validator.dart';
import 'package:maajabu/util/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class Vote extends StatefulWidget {
  const Vote({Key key, @required this.cd}) : super(key: key);
  final Candidate cd;

  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  final formKey = new GlobalKey<FormState>();

  String _justesse, _techvocal,_originalite,_diction,_expression;
  bool isLoading = false;
  double cote=0;
  double pt=0;
  var values = <double>[0,0,0,0,0];

  @override
  Widget build(BuildContext context) {
    final justesse = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter valid Justesse marks" : null,
      onSaved: (value) => _justesse = value,
      onChanged: (value) => coteChanged(value,0),
      decoration: InputDecoration(
        prefixIcon: new Icon(Icons.edit, color: MaajabuAppTheme.goldDark),
        hintText: "",
        hintStyle: new TextStyle(color: MaajabuAppTheme.nearlyWhite),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelText: "Justesse",
        border: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelStyle: TextStyle(color: MaajabuAppTheme.goldDark),
        suffix: Text("/4"),

      ),
      keyboardType: TextInputType.number,
      cursorColor: MaajabuAppTheme.goldDark,
      style: TextStyle(color: MaajabuAppTheme.nearlyWhite),
    );
    final techvocal = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter valid technique vocal marks" : null,
      onSaved: (value) => _techvocal = value,
      onChanged: (value) => coteChanged(value,1),

      keyboardType: TextInputType.number,
      decoration: InputDecoration(

        prefixIcon: new Icon(Icons.edit, color: MaajabuAppTheme.goldDark),
        hintText: "",
        hintStyle: new TextStyle(color: MaajabuAppTheme.nearlyWhite),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelText: "Technique Vocal",
        border: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelStyle: TextStyle(color: MaajabuAppTheme.goldDark),
        suffix: Text("/4"),


      ),
      cursorColor: MaajabuAppTheme.goldDark,
      style: TextStyle(color: MaajabuAppTheme.nearlyWhite),

    );
    final originalite = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter valid Originalite marks" : null,
      onSaved: (value) => _originalite = value,
      onChanged: (value) => coteChanged(value,2),
      decoration: InputDecoration(
        prefixIcon: new Icon(Icons.edit, color: MaajabuAppTheme.goldDark),
        hintText: "",
        hintStyle: new TextStyle(color: MaajabuAppTheme.nearlyWhite),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelText: "Originalite",
        border: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelStyle: TextStyle(color: MaajabuAppTheme.goldDark),
        suffix: Text("/4"),

      ),
      keyboardType: TextInputType.number,
      cursorColor: MaajabuAppTheme.goldDark,
      style: TextStyle(color: MaajabuAppTheme.nearlyWhite),



    );
    final diction = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter valid Diction maks" : null,
      onSaved: (value) => _diction = value,
      onChanged: (value) => coteChanged(value,3),
      decoration: InputDecoration(
        prefixIcon: new Icon(Icons.edit, color: MaajabuAppTheme.goldDark),
        hintText: "",
        hintStyle: new TextStyle(color: MaajabuAppTheme.nearlyWhite),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelText: "Diction",
        border: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelStyle: TextStyle(color: MaajabuAppTheme.goldDark),
        suffix: Text("/4"),

      ),
      keyboardType: TextInputType.number,
      cursorColor: MaajabuAppTheme.goldDark,
      style: TextStyle(color: MaajabuAppTheme.nearlyWhite),

    );
    final expression = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter valid Expression marks" : null,
      onSaved: (value) => _expression = value,
      onChanged: (value) => coteChanged(value,4),
      decoration: InputDecoration(
        prefixIcon: new Icon(Icons.edit, color: MaajabuAppTheme.goldDark),
        hintText: "",
        hintStyle: new TextStyle(color: MaajabuAppTheme.nearlyWhite),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelText: "Expression",
        border: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MaajabuAppTheme.goldDark),),
        labelStyle: TextStyle(color: MaajabuAppTheme.goldDark),
        suffix: Text("/4"),

      ),
      keyboardType: TextInputType.number,
      cursorColor: MaajabuAppTheme.goldDark,
      style: TextStyle(color: MaajabuAppTheme.nearlyWhite),



    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Submitting... Please wait", style: TextStyle(color: MaajabuAppTheme.goldDark),)
      ],
    );

    var doSubmit = (){

      final form = formKey.currentState;
      if (form.validate()) {
        setState(() {
          isLoading = true;
        });
        form.save();
        print("submitting");
        sendData(_justesse, _techvocal, _originalite,_diction,_expression).then((value) =>() {
          print("submitting2");
          setState(() {
            isLoading = false;
          });
          if(value.statusCode == 200){

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
              content: Text(value.body.toString()),
              )
            );
            Navigator.pop(context);
            //this._openPopup(context);

            //value.body
          }else{

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Failed to send data"),
                )
            );
          }

        }
        ).catchError((onError){
          print(onError.toString());
        });
      }
    };

    return Scaffold(
      backgroundColor: MaajabuAppTheme.black,
      appBar: AppBar(
        leading: Icon(Icons.how_to_vote,color: MaajabuAppTheme.goldLight,),
        title: Text("${widget.cd.firstname} ${widget.cd.lastname}  ${widget.cd.numero}", style: TextStyle(color: MaajabuAppTheme.goldLight),),
        backgroundColor: MaajabuAppTheme.black.withOpacity(0.8),
        elevation: 50.0,
      ),
      body: SingleChildScrollView(
    child: Container(
          padding: EdgeInsets.only(top: 10.0,left: 50.0,right: 50.0,bottom: 50.0),
          color: MaajabuAppTheme.black,
          child: Column(
            children: <Widget>[
              //Text("Votre mension pour ${widget.cd.firstname}", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800, color: MaajabuAppTheme.goldDark),),

              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset('assets/Maaj07.png', fit: BoxFit.cover),
              ),
              SizedBox(height: 20.0),
              Text("${pt} %",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w900, color: MaajabuAppTheme.goldDark,),textAlign: TextAlign.right,),
              SizedBox(height: 15.0),
              Form(
                key: formKey,
                child:Column(
                  children:<Widget>[

                    justesse,
                    SizedBox(height: 15.0),

                    techvocal,
                    SizedBox(height: 15.0),

                    originalite,
                    SizedBox(height: 15.0),
                    diction,
                    SizedBox(height: 15.0),
                    expression,
                    SizedBox(height: 15.0),
                    isLoading ? loading : longButtons("Valider", doSubmit,color: MaajabuAppTheme.goldDark,textColor:Color(68703105111), )

                  ],


                )

              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<http.Response> sendData(String mjustesse, String mtechvocal, String moriginalite, String mdiction, String mexpression){
    DataService ds = new DataService();
    var cotation = new Cotation(candidateId: widget.cd.id,
    justesse: mjustesse,
    techvocal: mtechvocal,
    originalite: moriginalite,
    diction: mdiction,
    expression: mexpression,
    cote: pt);
    return ds.sendData(cotation);

  }
  /*Future<http.Response> sendData(String mjustesse, String mtechvocal, String moriginalite, String mdiction, String mexpression){
    return http.post(
      Uri.parse('http://192.168.43.199/maajabu/public/api/votejury'),
      headers: <String, String>{
        'Content-Type':'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': widget.cd.id,
        'justesse':mjustesse,
        'technich_vocal':mtechvocal,
        'originalite':moriginalite,
        'diction':mdiction,
        'expression':mexpression
      })
    );
  }*/
  _openPopup(context) {

    Alert(
        context: context,
        title: "Selectionez la categorie ",
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return
                 Column(
                  children: <Widget>[
                    Center(
                      child: Image.asset('assets/check.png', width: 30.0,height: 30.0,),
                    ),

                    Center(
                      child:Text("Merci!", style: TextStyle(fontWeight: FontWeight.w900),),
                    ),

                    Text("Cotation effectue avec succes.",),
                    /* TextField(   0
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: 'Username',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
            ),*/
                  ],
                );
            }
        ),

        buttons: [
          DialogButton(
            color: Colors.amber,

            onPressed: (){

              //createPayment(getVoteModeValue(dropdownValue), candidate);
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style: TextStyle(color: MaajabuAppTheme.goldDark, fontSize: 20),
            ),
          )
        ]).show();
  }
  coteChanged(value,int i){
    double v = double.parse(value);
    values[i] = v;
    double ptg;
    cote = values[0] + values[1] + values[2] + values[3] + values[4];
    ptg =  (cote*100) /20;
    pt = ptg;
    setState(() {    
      pt;
    });


  }
}
