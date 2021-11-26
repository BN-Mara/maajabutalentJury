
class Cotation{
  int candidateId;
  String justesse,techvocal,originalite,diction,expression;
  double cote;
  Cotation({this.candidateId,this.justesse,this.techvocal,this.originalite,this.diction,this.expression,this.cote});

  factory  Cotation.fromJson(Map<String,dynamic>json){
    return Cotation(
      candidateId: json['id'],
      justesse: json['description'],
      techvocal: json['techvocal'],
      originalite: json['originalite'],
      diction: json['diction'],
      expression: json['expression'],
    );
  }

}