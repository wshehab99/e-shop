import 'base_response.dart';
import 'product_response.dart';

class CartResponse extends BaseResponse {
  List<ProductResponse> ?cart;
  CartResponse(super.status, super.message, this.cart);
  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
      json["status"] as int,
      json["message"] as String,
      (json["cart"] as List<dynamic>)
          .map((element) =>
              ProductResponse.fromJson(element as Map<String, dynamic>))
          .toList());
}
