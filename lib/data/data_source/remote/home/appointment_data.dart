import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class AppointmentData {
  Crud crud;

  AppointmentData(this.crud);

  getData(String salonId) async {
    var response = await crud.postData(AppLink.appointmentView, {
      "salonid": salonId,
    });
    return response.fold((l) => l, (r) => r);
  }

  postData(
    String salonId,
    String saturday,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
  ) async {
    var response = await crud.postData(AppLink.appointmentAdd, {
      "salonid": salonId,
      "saturday": saturday,
      "sunday": sunday,
      "monday": monday,
      "tuesday": tuesday,
      "wednesday": wednesday,
      "thursday": thursday,
      "friday": friday,
    });
    return response.fold((l) => l, (r) => r);
  }
}
