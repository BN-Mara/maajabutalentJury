class AppUser{
  int userId;
  String firstname;
  String lastname;
  String address;
  String email;
  String phone;
  String token;
  String renewalToken;
  AppUser({this.userId,this.firstname,this.lastname,this.address,this.email,this.phone,this.token,this.renewalToken});

  factory AppUser.fromJson(Map<String, dynamic> responseData) {
    return AppUser(
        userId: responseData['id'],
        firstname: responseData['firstname'],
        lastname: responseData['lastname'],
        email: responseData['email'],
        phone: responseData['phone'],
        address: responseData['address'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']
    );
  }


}