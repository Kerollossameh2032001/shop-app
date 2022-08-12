class LoginModel {
  late bool status;
  late String? message;
  late DataModel? data;

  LoginModel.fromJson(Map<String, dynamic>json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataModel.formJson(json['data']) : null;
  }
}

class DataModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late dynamic points;
  late dynamic credit;
  late String token;

  DataModel.formJson(Map<String, dynamic>json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}