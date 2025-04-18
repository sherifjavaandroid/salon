class ServicesModel {
  dynamic id;
  int? salonId;
  String? name;
  dynamic time;
  String? image;
  dynamic price;

  ServicesModel({
    this.id,
    this.salonId,
    this.name,
    this.time,
    this.image,
    this.price,
  });

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salonId = json['salon_id'];
    name = json['name'];
    time = json['time'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['salon_id'] = this.salonId;
    data['name'] = this.name;
    data['time'] = this.time;
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}
