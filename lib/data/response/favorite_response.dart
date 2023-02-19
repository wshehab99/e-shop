import 'package:sneakers_shop/data/response/product_response.dart';

import 'base_response.dart';

class FavoriteResponse extends BaseResponse {
  List<ProductResponse>? favorites;
  FavoriteResponse(super.status, super.message,this.favorites);
  factory FavoriteResponse.fromJson(Map<String,dynamic>json)=>FavoriteResponse(json["status"],json["message"],
  (json["favorites"]as List<dynamic>).map((product) => ProductResponse.fromJson(product as Map<String,dynamic>)).toList() );
  
}
