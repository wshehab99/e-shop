class ContactResponse {
  String? name;
  String? phone;
  String? email;
  ContactResponse(this.name, this.phone, this.email);
  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(json["name"] as String?, json["phone"] as String?,
          json["email"] as String?);
  Map<String, dynamic> toJson() =>
      <String, dynamic>{"name": name, "phone": phone, "email": email};
}
