class CustomerModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? country;
  String? city;
  String? address;

  CustomerModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.country,
    this.city,
    this.address,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
  }
}
