class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? verifycode;
  String? phone;
  String? image;
  String? gender;
  String? approve;
  String? country;
  String? city;
  String? address;
  String? createdAt;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.verifycode,
    this.phone,
    this.image,
    this.gender,
    this.approve,
    this.country,
    this.city,
    this.address,
    this.createdAt,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    image = json['image'];
    verifycode = json['verifycode'];
    approve = json['approve'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['verifycode'] = this.verifycode;
    data['approve'] = this.approve;
    data['country'] = this.country;
    data['city'] = this.city;
    data['address'] = this.address;
    data['created_at'] = this.createdAt;
    return data;
  }
}
