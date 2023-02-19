

import 'package:sneakers_shop/data/mapper/home_mapper.dart';

import '../../domain/model/favorite_model.dart';
import '../../domain/model/home_model.dart';
import '../response/favorite_response.dart';

extension FavoriteExtension on FavoriteResponse? {
  FavoriteModel toModel() {
    final List<ProductResponseModel> favList =
        this?.favorites?.map((product) => product.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();
    return FavoriteModel(favList);
  }
}
