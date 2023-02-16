import 'base_response.dart';
import 'product_response.dart';

class HomeResponse extends BaseResponse {
  HomeDataResponse? data;
  HomeResponse(super.status, super.message, this.data);
  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        json["status"] as int?,
        json["message"] as String?,
        HomeDataResponse.fromJson(json["data"]),
      );
}

class HomeDataResponse {
  List<ProductResponse>? upcoming;
  List<ProductResponse>? featured;
  List<ProductResponse>? news;
  List<ProductResponse>? more;
  HomeDataResponse(this.upcoming, this.featured, this.news, this.more);
  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      HomeDataResponse(
        (json["upcoming"] as List<dynamic>)
            .map((element) =>
                ProductResponse.fromJson(element as Map<String, dynamic>))
            .toList(),
        (json["featured"] as List<dynamic>)
            .map((element) =>
                ProductResponse.fromJson(element as Map<String, dynamic>))
            .toList(),
        (json["new"] as List<dynamic>)
            .map((element) =>
                ProductResponse.fromJson(element as Map<String, dynamic>))
            .toList(),
        (json["more"] as List<dynamic>)
            .map((element) =>
                ProductResponse.fromJson(element as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        "upcoming": upcoming?.map((e) => e.toJson()).toList() ?? [],
        "featured": featured?.map((e) => e.toJson()).toList() ?? [],
        "new": news?.map((e) => e.toJson()).toList() ?? [],
        "more": more?.map((e) => e.toJson()).toList() ?? [],
      };
}
