// ignore_for_file: file_names

class HomeModel {
  HomeModel();
  late bool status;
  late HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  HomeDataModel();
  late List<ProductModel> products = [];
  late List<BannerModel> banners = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners']
        .forEach((element) => banners.add(BannerModel.fromJson(element)));
    json['products']
        .forEach((element) => products.add(ProductModel.fromJson(element)));
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late num oldprice, price,discount;
  late String image, name;
  late bool incart, infavorites;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldprice = json['old_price'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    incart = json['in_cart'];
    infavorites = json['in_favorites'];
  }
}
