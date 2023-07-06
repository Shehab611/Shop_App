// ignore_for_file: file_names

class ShopLoginModel {
  late String message;
  late bool status;
  late UserData data;
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    message = (json['message'] != null) ? json['message'] : '';
    status = json['status'];
    data =
        (json['data'] != null) ? UserData.fromJson(json['data']) : UserData();
  }
}

class UserData {
  UserData();
  late int id, credit, points;
  late String name, email, phone, image, token;
  UserData.fromJson(Map<String, dynamic> json) {
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
