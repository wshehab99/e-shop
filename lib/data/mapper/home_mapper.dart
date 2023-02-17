import '../../app/app_extensions.dart';
import '../../app/app_constant.dart';
import '../../domain/model/home_model.dart';
import '../response/home_response.dart';
import '../response/product_response.dart';

extension ProductResponseExtension on ProductResponse? {
  ProductResponseModel toModel() => ProductResponseModel(
        this?.id.orEmpty() ?? AppConstants.empty,
        this?.brand.orEmpty() ?? AppConstants.empty,
        this?.model.orEmpty() ?? AppConstants.empty,
        this?.price.orZero() ?? 0,
        this?.imgUrl.orEmpty() ?? AppConstants.empty,
      );
}

extension HomeDataResponseExtension on HomeResponse? {
  HomeModel toModel() {
    final List<ProductResponseModel> upcoming =
        this?.data?.upcoming?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();

    final List<ProductResponseModel> featured =
        this?.data?.featured?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();
    final List<ProductResponseModel> news =
        this?.data?.news?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();
    final List<ProductResponseModel> more =
        this?.data?.more?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<ProductResponseModel>().toList();
    return HomeModel(HomeDataResponseModel(upcoming, featured, news, more));
  }
}
