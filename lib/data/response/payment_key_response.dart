class PaymentKeyResponse {
  String? token;
  PaymentKeyResponse(this.token);
  factory PaymentKeyResponse.fromJson(Map<String, dynamic> json) =>
      PaymentKeyResponse(json["token"] as String?);
}
