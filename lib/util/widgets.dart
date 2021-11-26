import 'package:flutter/material.dart';
import 'package:maajabu/util/themedata.dart';

MaterialButton longButtons(String title, Function fun,
    {Color color: const Color(0xfff063057), Color textColor: Colors.white}) {
  return MaterialButton(
    
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}
Card baseButton(String text, Function fun,  {Color color: const Color(0xfff063057), Color textColor: Colors.white} ){
  return  Card(
    elevation: 7,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Container(
      
      padding: EdgeInsets.only(left: 20.0,right: 20.0),
      height: 50.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            MaajabuAppTheme.goldDark,
            MaajabuAppTheme.goldLight,
            MaajabuAppTheme.gold,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  
        onPressed: fun,
        splashColor: Colors.grey,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 20.0),
        ),
      ),
    ),
  );

}
label(String title) => Text(title,style: TextStyle(color: MaajabuAppTheme.goldDark),);
appbarTitle (String title) => Text(title,style: TextStyle(color: MaajabuAppTheme.goldLight),);

InputDecoration buildInputDecoration(String hintText, IconData icon, {String sufixText=""}) {
  return /*InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );*/
  InputDecoration(
    filled: true,
    fillColor: MaajabuAppTheme.notWhite,
    focusColor: MaajabuAppTheme.notWhite,
    prefixIcon: Icon(icon, color: MaajabuAppTheme.goldDark),
    hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MaajabuAppTheme.goldDark)),
                                    focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: MaajabuAppTheme.goldDark)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color:
                                        MaajabuAppTheme.goldDark)),
                                        suffix: Text(sufixText)
      );
}
