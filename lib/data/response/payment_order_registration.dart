class PaymentOrderRegistrationResponse {
  int? id;
  String? created_at;
  String? delivery_needed;
  PaymentOrderMerchant? merchant;
  String? collector;
  int? amount_cents;
  PaymentOrderShippingData? shipping_data;
  String? currency;
  String? is_payment_locked;
  String? merchant_order_id;
  String? wallet_notification;
  int? paid_amount_cents;
  PaymentOrderRegistrationResponse(
      this.id,
      this.created_at,
      this.delivery_needed,
      this.merchant,
      this.collector,
      this.amount_cents,
      this.shipping_data,
      this.currency,
      this.is_payment_locked,
      this.merchant_order_id,
      this.wallet_notification,
      this.paid_amount_cents);
}

class PaymentOrderMerchant {
  int? id;
  String? created_at;
  List<String>? phones;
  List<String>? company_emails;

  String? company_name;
  String? state;
  String? country;
  String? city;
  String? postal_code;
  String? street;
  PaymentOrderMerchant(
      this.id,
      this.created_at,
      this.phones,
      this.company_emails,
      this.company_name,
      this.state,
      this.country,
      this.city,
      this.postal_code,
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
