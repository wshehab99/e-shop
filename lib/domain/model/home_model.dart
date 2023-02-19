import 'package:sneakers_shop/app/app_constant.dart';

class HomeModel {
  HomeDataResponseModel data;

  HomeModel(this.data);
}

class HomeDataResponseModel {
  List<ProductResponseModel> upcoming;
  List<ProductResponseModel> featured;
  List<ProductResponseModel> news;
  List<ProductResponseModel> more;
  HomeDataResponseModel(this.upcoming, this.featured, this.news, this.more);
}

class ProductResponseModel {
  String id;
  String brand;
  String model;
  double price;
  String imgUrl;
  ProductResponseModel(
      this.id, this.brand, this.model, this.price, this.imgUrl);
  factory ProductResponseModel.empty() => ProductResponseModel(
      AppConstants.empty,
      AppConstants.empty,
      AppConstants.empty,
      0.0,
      AppConstants.empty);
}
