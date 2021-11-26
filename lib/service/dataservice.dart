import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:maajabu/api/appurl.dart';
import 'package:maajabu/model/cotation.dart';

class DataService{
  Future<http.Response> sendData(Cotation ct){
    return http.post(
      AppUrl.cotation,
      headers: <String, String>{
        'Content-Type':'application/json;charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'candidateId': ct.candidateId,
        'justesse':ct.justesse,
        'technich_vocal':ct.techvocal,
        'originalite':ct.originalite,
        'diction':ct.diction,
        'expression':ct.expression
      })
    );
  }
}