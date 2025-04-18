class ProductModel {
  int? id;
  int? salonId;
  String? name;
  int? number;
  String? image;
  int? price;

  ProductModel({
    this.id,
    this.salonId,
    this.name,
    this.number,
    this.image,
    this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    name = json['name'];
    number = json['number'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
