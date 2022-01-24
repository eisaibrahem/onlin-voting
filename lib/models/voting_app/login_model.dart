class VotingLoginModel{

  bool? status;
  String? message;
  UserData? data;

  VotingLoginModel(

      );

  // named constructor
  VotingLoginModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']  !=null ? UserData.fromJson(json['data']) : null;
  }
}


class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData(
      {
        this.email,
        this.image,
        this.phone,
        this.id,
        this.name,
        this.credit,
        this.points,
        this.token,
      });


  //named constructor
  UserData.fromJson(Map<String,dynamic>json)
  {

    id=json['id'];
    phone=json['phone'];
    email=json['email'];
    image=json['image'];
    name=json['name'];
    credit=json['credit'];
    points=json['points'];
    token=json['token'];



  }



}