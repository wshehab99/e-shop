import 'package:sneakers_shop/app/app_constant.dart';
import 'package:sneakers_shop/data/mapper/home_mapper.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';

import '../../domain/model/cart_model.dart';
import '../response/cart_response.dart';
import '../response/product_response.dart';

extension CartModelExtension on CartResponse? {
  CartModel toModel() {
    final List<ProductResponseModel> cartList =
        this?.cart?.map((product) => product.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();
    return CartModel(cartList);
  }
}
extension CartResponseExtension on CartModel? {
  CartResponse toResponse() {
    final List<ProductResponse> cartList =
        this?.cart.map((product) => product.toResponse()).toList() ??
            const Iterable.empty().cast<ProductResponse>().toList();
    return CartResponse(0,AppConstants.empty,cartList);
  }
}