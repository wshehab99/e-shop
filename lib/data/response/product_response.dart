class ProductResponse {
  String? id;
  String? brand;
  String? model;
  double? price;
  String? imgUrl;
  ProductResponse(this.id, this.brand, this.model, this.price, this.imgUrl);
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
          json["id"] as String?,
          json["brand"] as String?,
          json["model"] as String?,
          json["price"] as double?,
          json["imgUrl"] as String?);
  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "brand": brand,
        "model": model,
        "price": price,
        "imgUrl": imgUrl
      };
}
