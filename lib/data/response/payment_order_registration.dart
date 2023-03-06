class PaymentOrderRegistrationResponse {
  int? id;
  String? createdAt;
  String? deliveryNeeded;
  PaymentOrderMerchant? merchant;
  String? collector;
  int? amountCents;
  PaymentOrderShippingData? shippingData;
  String? currency;
  String? isPaymentLocked;
  String? merchantOrderId;
  String? walletNotification;
  int? paidAmountCents;
  PaymentOrderRegistrationResponse(
      this.id,
      this.createdAt,
      this.deliveryNeeded,
      this.merchant,
      this.collector,
      this.amountCents,
      this.shippingData,
      this.currency,
      this.isPaymentLocked,
      this.merchantOrderId,
      this.walletNotification,
      this.paidAmountCents);
  factory PaymentOrderRegistrationResponse.fromJson(
          Map<String, dynamic> json) =>
      PaymentOrderRegistrationResponse(
        json["id"]as int?,
         json["created_at"]as String?,
         json["delivery_needed"]as String?,
        PaymentOrderMerchant.fromJson(json["merchant"] as Map<String, dynamic>),
         json["collector"]as String?,
         json["amount_cents"]as int?,
    PaymentOrderShippingData.fromJson(json["shipping_data"as Map<String, dynamic>] )  ,
         json["currency"]as String?,
         json["is_payment_locked"]as String?,
         json["merchant_order_id"]as String?,
         json["wallet_notification"]as String?,
         json["paid_amount_cents"]as int?,
      );
}

class PaymentOrderMerchant {
  int? id;
  String? createdAt;
  List<String>? phones;
  List<String>? companyEmails;

  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;
  PaymentOrderMerchant(
      this.id,
      this.createdAt,
      this.phones,
      this.companyEmails,
      this.companyName,
      this.state,
      this.country,
      this.city,
      this.postalCode,
      this.street);
  factory PaymentOrderMerchant.fromJson(Map<String, dynamic> json) =>
      PaymentOrderMerchant(
        json["id"] as int?,
        json["created_at"] as String?,
        json['phones'] as List<String>?,
        json['company_emails'] as List<String>?,
        json["company_name"] as String?,
        json["state"] as String?,
        json["country"] as String?,
        json["city"] as String?,
        json["postal_code"] as String?,
        json["street"] as String?,
      );
}

class PaymentOrderShippingData {
  int? id;
  String? firstName;
  String? lastName;
  String? street;
  String? building;
  String? floor;
  String? apartment;
  String? city;
  String? state;
  String? country;
  String? email;
  String? phoneNumber;
  String? postalCode;
  String? extraDescription;
  String? shippingMethod;
  int? orderId;
  int? order;
  PaymentOrderShippingData(
      this.id,
      this.firstName,
      this.lastName,
      this.street,
      this.building,
      this.floor,
      this.apartment,
      this.city,
      this.state,
      this.country,
      this.email,
      this.phoneNumber,
      this.postalCode,
      this.extraDescription,
      this.shippingMethod,
      this.orderId,
      this.order);
  factory PaymentOrderShippingData.fromJson(Map<String, dynamic> json) =>
      PaymentOrderShippingData(
        json['id'] as int?,
        json['first_name'] as String?,
        json['last_name'] as String?,
        json['street'] as String?,
        json['building'] as String?,
        json['floor'] as String?,
        json['apartment'] as String?,
        json['city'] as String?,
        json['state'] as String?,
        json['country'] as String?,
        json['email'] as String?,
        json['phone_number'] as String?,
        json['postal_code'] as String?,
        json['extra_description'] as String?,
        json['shipping_method'] as String?,
        json['order_id'] as int?,
        json['order'] as int?,
      );
}
