import 'home_model.dart';

class BagItem {
  int numberOfItems;
  ProductResponseModel product;
  BagItem(this.product, this.numberOfItems);
}

extension BagItemExt on ProductResponseModel {
  BagItem toBag() => BagItem(this, 1);
}
