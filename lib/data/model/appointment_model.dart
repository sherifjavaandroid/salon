class AppointmentModel {
  int? id;
  String? saturday;
  String? sunday;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;

  AppointmentModel({
    this.id,
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id']; // Directly assign the value from JSON
    saturday = json['saturday'];
    sunday = json['sunday'];
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['saturday'] = saturday;
    data['sunday'] = sunday;
    data['monday'] = monday;
    data['tuesday'] = tuesday;
    data['wednesday'] = wednesday;
    data['thursday'] = thursday;
    data['friday'] = friday;
    return data;
  }
}
