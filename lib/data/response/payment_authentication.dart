class PaymentAuthenticationResponse {
  String? token;
  PaymentAuthenticationResponse(this.token);
  factory PaymentAuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      PaymentAuthenticationResponse(json['token'] as String?);
}
