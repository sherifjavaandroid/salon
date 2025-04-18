import 'dart:io';

import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/data/data_source/remote/home/profile_data.dart';
import 'package:easycut_business/data/model/salon_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProfileController extends GetxController {
  getSalonData();
  editProfile();
}

class ProfileControllerImp extends ProfileController {
  late String salonId;
  String reminder = "0";
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  ProfileData salonDetail = ProfileData(Get.find());
  SalonModel salon = SalonModel();

  @override
  getSalonData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await salonDetail.getData(
      salonId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (kDebugMode) {
          print('!!!!!!!!!!!!!@@!$response');
        }
        var data = response['data'] as Map<String, dynamic>;
        salon = SalonModel.fromJson(data);
        myServices.sharedPreferences.setString('image', salon.image!);
      } else {
        Get.snackbar(
          'Warning',
          'There is no data',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController chairsNumber;
  File? myFile;

  void addFilePath(String path) {
    myFile = File(path);
    update();
  }

  @override
  editProfile() async {
    if (myFile == null) {
      return Get.defaultDialog(
        title: "Warning",
        content: const SmallText(
          text: "You must upload image for your Salon",
        ),
      );
    }
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await salonDetail.postData(
        salonId,
        chairsNumber.text,
        salon.image!,
        myFile!,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(
            'Success',
            'Edit Profile',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.green,
          );

          Get.offNamed(AppRoute.salonProfile);
        } else {
          statusRequest = StatusRequest.none;
        }
      }
      update();
    }
  }

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id')!;
    chairsNumber = TextEditingController();
    getSalonData();
    super.onInit();
  }
}
