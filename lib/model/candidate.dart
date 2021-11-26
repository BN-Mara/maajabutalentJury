
class Candidate{
  String firstname,lastname,sex;
  int id,numero;
  Candidate({this.id,this.firstname,this.lastname,this.sex,this.numero});
  factory  Candidate.fromJson(Map<String, dynamic> json){
    return Candidate(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      sex: json['sex'],
      numero: json['numero']
    );
  }

}