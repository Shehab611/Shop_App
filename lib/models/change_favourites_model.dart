class ChangeFavourtiesModel {
  late bool status;
  late String msg;
  ChangeFavourtiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['message'];
  }
}
