class BaseResponse {
  int? status;
  String? message;
  BaseResponse(this.status, this.message);
  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      BaseResponse(json["status"] as int?, json["message"] as String?);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'status': status, "message": message};
}
