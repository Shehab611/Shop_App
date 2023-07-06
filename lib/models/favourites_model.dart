class FavourtiesModel {
  late bool status;
  late FavourtiesDataModel data;

  FavourtiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? FavourtiesDataModel.fromJson(json['data'])
        : FavourtiesDataModel();
  }
}

class FavourtiesDataModel {
  FavourtiesDataModel();
  late int currentPage, from, lastPage, total, to, perPage;
  late List<Data> data=[];
  late String firstPageUrl, lastPageUrl, path;

  FavourtiesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
  json['data'].forEach((element)=>data.add(Data.fromJson(element)));
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    path = json['path'];
    perPage = json['per_page'];

    to = json['to'];
    total = json['total'];
  }
}

class Data {
  late int id;
  late Product product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : Product();
  }
}

class Product {
  late int id, discount;
  late num price, oldPrice;
  late String image, description, name;
  Product();

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
