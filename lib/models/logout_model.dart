class LogoutModel{
  late bool status;
  late String message;
  late LogoutDataModel? data;

  LogoutModel.formJson(Map<String, dynamic>json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LogoutDataModel.formJson(json['data']) : null;
  }
}

class LogoutDataModel {
  late int id;
  late String token;

  LogoutDataModel.formJson(Map<String, dynamic> json){
    id = json['id'];
    token = json['token'];
  }
}