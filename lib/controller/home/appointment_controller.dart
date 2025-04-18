import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/data_source/remote/home/appointment_data.dart';
import 'package:easycut_business/data/model/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppointmentsController extends GetxController {
  getAppointmentsData();
  addAppointmentsData();
}

class AppointmentsControllerImp extends AppointmentsController {
  late String salonId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  AppointmentData appointmentData = AppointmentData(Get.find());
  AppointmentModel appointment = AppointmentModel();

  @override
  getAppointmentsData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await appointmentData.getData(
      salonId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        var data = response['data'] as Map<String, dynamic>;
        appointment = AppointmentModel.fromJson(data);
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  String startTimeSat = "9:00 AM";
  String startTimeSun = "9:00 AM";
  String startTimeMon = "9:00 AM";
  String startTimeTue = "9:00 AM";
  String startTimeWed = "9:00 AM";
  String startTimeThu = "9:00 AM";
  String startTimeFri = "9:00 AM";
  String endTimeSat = "9:00 PM";
  String endTimeSun = "9:00 PM";
  String endTimeMon = "9:00 PM";
  String endTimeTue = "9:00 PM";
  String endTimeWed = "9:00 PM";
  String endTimeThu = "9:00 PM";
  String endTimeFri = "9:00 PM";

  void changeStartTimeSat(String value) {
    startTimeSat = value;
    update();
  }

  void changeStartTimeSun(String value) {
    startTimeSun = value;
    update();
  }

  void changeStartTimeMon(String value) {
    startTimeMon = value;
    update();
  }

  void changeStartTimeTue(String value) {
    startTimeTue = value;
    update();
  }

  void changeStartTimeWed(String value) {
    startTimeWed = value;
    update();
  }

  void changeStartTimeThu(String value) {
    startTimeThu = value;
    update();
  }

  void changeStartTimeFri(String value) {
    startTimeFri = value;
    update();
  }

  void changeEndTimeSun(String value) {
    endTimeSun = value;
    update();
  }

  void changeEndTimeSat(String value) {
    endTimeSat = value;
    update();
  }

  void changeEndTimeMon(String value) {
    endTimeMon = value;
    update();
  }

  void changeEndTimeTue(String value) {
    endTimeTue = value;
    update();
  }

  void changeEndTimeWed(String value) {
    endTimeWed = value;
    update();
  }

  void changeEndTimeThu(String value) {
    endTimeThu = value;
    update();
  }

  void changeEndTimeFri(String value) {
    endTimeFri = value;
    update();
  }

  @override
  addAppointmentsData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await appointmentData.postData(
      salonId,
      "$startTimeSat - $endTimeSat",
      "$startTimeSun - $endTimeSun",
      "$startTimeMon - $endTimeMon",
      "$startTimeTue - $endTimeThu",
      "$startTimeWed - $endTimeWed",
      "$startTimeThu - $endTimeThu",
      "$startTimeFri - $endTimeFri",
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Adding Appointments',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.green,
        );
        Get.offNamed(AppRoute.appointment);
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id')!;
    getAppointmentsData();
    super.onInit();
  }
}
