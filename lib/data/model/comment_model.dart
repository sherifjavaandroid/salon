class CommentModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? country;
  String? city;
  String? address;
  String? body;

  CommentModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.country,
    this.city,
    this.address,
    this.body,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    country = json['country'];
    city = json['city'];
    address = json['address'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['country'] = this.country;
    data['city'] = this.city;
    data['address'] = this.address;
    data['body'] = this.body;
    return data;
  }
}
