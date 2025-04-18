class BookingModel {
  int id;
  String? day;
  String? startTime;
  String? userName;
  int? total;
  int? approve;
  String? userImage;

  BookingModel({
    required this.id,
    this.day,
    this.startTime,
    this.userName,
    this.total,
    this.approve,
    this.userImage,
  });

  // Factory constructor to create a BookingModel from JSON data
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as int,
      day: json['day'] as String?,
      startTime:
          json['start_time'] as String?, // Mapping from 'start_time' in JSON
      userName: json['name'] as String?, // Mapping from 'name' in JSON
      total: json['total'] as int?,
      approve: json['approve'] as int?,
      userImage: json['image'] as String?, // Mapping from 'image' in JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'start_time': startTime, // Correcting to match API format
      'name': userName, // Correcting to match API format
      'total': total,
      'approve': approve,
      'image': userImage, // Correcting to match API format
    };
  }
}
