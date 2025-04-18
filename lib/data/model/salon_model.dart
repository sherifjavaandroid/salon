class SalonModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? rate;
  int? chairs;
  String? image;
  int? approve;
  int? subscription;
  String? country;
  String? city;
  String? address;
  String? createdAt;
  String? updatedAt;

  SalonModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.rate,
    this.subscription,
    this.chairs,
    this.image,
    this.approve,
    this.country,
    this.city,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  SalonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    rate = json['rate'];
    subscription = json['subscription'];
    chairs = json['chairs'];
    image = json['image'];
    approve = json['approve'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['rate'] = this.rate;
    data['subscription'] = this.subscription;
    data['chairs'] = this.chairs;
    data['image'] = this.image;
    data['approve'] = this.approve;
    data['country'] = this.country;
    data['city'] = this.city;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
