
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maajabu/model/appuser.dart';
import 'package:maajabu/model/candidate.dart';
import 'package:maajabu/model/votemode.dart';
import 'package:maajabu/screen/vote.dart';
import 'package:maajabu/service/userprovider.dart';
import 'package:maajabu/util/themedata.dart';
import 'package:maajabu/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final List<String> items = List<String>.generate(10000, (i) => 'Item $i');
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  /// /// This holds the item count
  // int counter = 0;
  TextEditingController _textController = TextEditingController();
  List<Candidate> candidates =  [Candidate(id: 1, firstname: "benjos", numero: 47, lastname: "mara", sex: "M"),
  Candidate(id: 2, firstname: "bero", numero: 78, lastname: "trams", sex: "M"),
  Candidate(id: 3, firstname: "nano", numero: 90, lastname: "tumika", sex: "M"),
  Candidate(id: 4, firstname: "folo", numero: 63, lastname: "olympic", sex: "M"),
  Candidate(id: 5, firstname: "scillia", numero: 84, lastname: "Manzaya", sex: "M"),
  Candidate(id: 6, firstname: "david", numero: 77, lastname: "nseye", sex: "M"),
  Candidate(id: 7, firstname: "jeancy", numero: 23, lastname: "emboka", sex: "M"),
  Candidate(id: 8, firstname: "aris", numero: 65, lastname: "manunga", sex: "M")];
  List<VoteMode> voteModes;
  String dropdownValue;
  Candidate candidate;
  bool isLoading = true;
  bool isModeLoading = true;
  List<String> voteDescriptions = [];
  List<Candidate> newDataList;
  Icon actionIcon = new Icon(Icons.search, color: MaajabuAppTheme.goldLight,);
  final key = new GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text("Candidats", style: new TextStyle(color: MaajabuAppTheme.goldLight),);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCandidates();
    fetchVoteTypes();
  }
  @override
  Widget build(BuildContext context) {

    //AppUser user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: MaajabuAppTheme.black,
      key: key,
      appBar: AppBar(
        title: appBarTitle,
        elevation: 50.0,
        backgroundColor: MaajabuAppTheme.black,
        actions: <Widget>[
          IconButton(icon: actionIcon,onPressed: (){
            setState(() {
              if(this.actionIcon.icon == Icons.search){
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new Container(
                  height: 35.0,
                  child: new TextField(
                  controller: _textController,
                  style: new TextStyle(
                    color: MaajabuAppTheme.black,

                  ),
                  decoration: buildInputDecoration("Search...", Icons.search),
                  onChanged: onItemChanged,

                ));

              }else{
                setState(() {
                  this.actionIcon = new Icon(Icons.search, color: MaajabuAppTheme.goldLight,);
                  this.appBarTitle =
                  new Text("Candidats",style: TextStyle(color: MaajabuAppTheme.goldLight),);
                  this.newDataList = List.from(this.candidates);
                });
              }

            });
          },)
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),

        /*decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              
              colors: <Color>[
                Colors.blue,
                Colors.red,
                Colors.yellow,
                Colors.greenAccent

              ],
            )
        ),*/
        color: MaajabuAppTheme.black,
        child :isLoading ? Center(
        child: CircularProgressIndicator(),
      ):AnimatedList(
    key: listKey,
    initialItemCount: candidates.length,
    itemBuilder: (context, index, animation) {
    return slideIt(context, index, animation); // Refer step 3
    },
    ),
      ),
    );
  }
  Candidate getCandidate(int ind){
    candidate = candidates[ind];
    /*setState(() {
      candidate;
    });*/

    return candidates[ind];
  }

  Widget slideIt(BuildContext context, int index, animation) {
    Candidate item = candidates[index];
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: SizedBox( // Actual widget to display
        height: 128.0,
        child: Card(
          color: Colors.primaries[item.id % Colors.primaries.length],
          child: Center(
            child:  ListTile(
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset('assets/Maaj07.png', fit: BoxFit.cover),
              ),
              title: Text('${newDataList[index].firstname} ${newDataList[index].lastname}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),),
              isThreeLine: true,
              subtitle: Text('No ${newDataList[index].numero}',style:TextStyle(color: Colors.white)),

              onTap: (){
                //getCandidate(index);
                //print()
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Vote(cd: newDataList[index])
                )
                );
                /*if(voteModes!= null)
              votemodeToarray();
            if(voteModes != null  && voteModes.isNotEmpty){
              _openPopup(context);
            }*/

              },


            ),
          ),
        ),
      ),
    );
  }



  _openPopup(context) {

    Alert(
        context: context,
        title: "Selectionez la categorie ",
        content: StatefulBuilder(

          builder: (BuildContext context, StateSetter setState) {
            return
              isModeLoading ? Center(child: CircularProgressIndicator()) : Column(
                children: <Widget>[
                   DropdownButton<String>(

                    value: this.dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      this.dropdownValue = newValue;
                      setState(() {
                        dropdownValue;
                        print(dropdownValue);
                      });

                    },
                    items: (voteDescriptions == null ? <String>["no data"].toList(): voteDescriptions)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          width: 150,

                            child: Text(value)
                        ),
                      );
                    }).toList(),
                  ),
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
              createPayment(getVoteModeValue(dropdownValue), candidate);
              Navigator.pop(context);
            },
            child: Text(
              "PAYER",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  List<String>  votemodeToarray(){

    if(voteModes != null)
    for(int i=0; i<voteModes.length;i++){

      setState(() {
        voteDescriptions.add(voteModes[i].description);

      });
    }

    print('177 : ${voteDescriptions[0]}');
    return voteDescriptions;
  }
  VoteMode getVoteModeValue(String description){
    if(voteModes != null) {
      List<VoteMode> votem = voteModes.where((element) =>
      element.description == description).toList();
      return votem[0];
    }
    else
      return null;
  }

  createPayment(VoteMode  vm, Candidate cd){
    //pay with paypal
    print('${vm.description} ${cd.firstname}');
  }


  Future<List<Candidate>> fetchCandidates() async{
    setState(() {
        candidates;
        newDataList = List.from(candidates);
        isLoading=false;
      }
      );
   /* final response = await http.get(Uri.parse('http://192.168.43.199/maajabu/public/api/candidates'));
    if(response.statusCode  == 200){
      candidates  = (json.decode(response.body) as List).map((i) =>
          Candidate.fromJson(i)).toList();
      setState(() {
        candidates;
        newDataList = List.from(candidates);
        isLoading=false;
      }
      );
      print(candidates.first.firstname);
    }else{
      throw Exception('Failed to load candidates');
    }*/
    return candidates;
  }
  Future<List<VoteMode>> fetchVoteTypes() async{
    final response = await http.get(Uri.parse('http://192.168.43.199/maajabu/public/api/votemodes'));
    if(response.statusCode  == 200){
      voteModes  = (json.decode(response.body) as List).map((i) =>
          VoteMode.fromJson(i)).toList();
      setState(() {
        voteModes;
        isModeLoading = false;
      });

      //print(voteModes.first.description);
    }else{
      throw Exception('Failed to load candidates');
    }

    return voteModes;
  }
  onItemChanged(String value) {
    //newDataList.clear();
    if (value.isEmpty) {
      newDataList = List.from(candidates);
      setState(() {});
      return;
    }
    newDataList.clear();
    candidates.forEach((element) {
      if(element.firstname.contains(value) || element.lastname.contains(value) || element.numero.toString().contains(value)){
        newDataList.add(element);
      }
    });
    setState(() {
    });
  }

}