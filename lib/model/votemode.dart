
class VoteMode{
  int id, quantity;
  String description;
  double price;
  VoteMode({this.id,this.description,this.price,this.quantity});

  factory  VoteMode.fromJson(Map<String,dynamic>json){
    return VoteMode(
      id: json['id'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

}