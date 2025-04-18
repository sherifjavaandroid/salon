import 'dart:io';

import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/data/data_source/remote/home/services_data.dart';
import 'package:easycut_business/data/model/services_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ServicesController extends GetxController {
  getServicesData();
  addServicesData();
}

class ServicesControllerImp extends ServicesController {
  late String salonId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  ServicesData servicesData = ServicesData(Get.find());
  List<ServicesModel> services = [];

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController serviceName;
  late TextEditingController serviceTime;
  late TextEditingController servicePrice;
  File? myFile;

  @override
  getServicesData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await servicesData.getData(salonId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        services = data.map((e) => ServicesModel.fromJson(e)).toList();
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  void addFilePath(String path) {
    myFile = File(path);
    update();
  }

  @override
  addServicesData() async {
    if (myFile == null) {
      return Get.defaultDialog(
        title: "Warning",
        content: const SmallText(
          text: "You must upload an image for your service",
        ),
      );
    }
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await servicesData.postData(
        salonId,
        serviceName.text,
        servicePrice.text,
        serviceTime.text,
        myFile!,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        Get.snackbar(
          'Success',
          'Service added successfully',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.green,
        );
        Get.offNamed(AppRoute.services);
      } else {
        statusRequest = StatusRequest.none;
      }
      update();
    }
  }

  // New edit service data method
  Future<void> editServiceData(
      String id, String name, String price, String time, File image) async {
    // API call to edit service data
    var response = await servicesData.editData(id, name, price, time, image);
    if (response != null && response['status'] == "success") {
      await getServicesData(); // Refresh the list on success
      update(); // Update UI
    } else {
      print("Failed to edit service.");
    }
  }

  Future<void> deleteProductData(String id, String oldImage) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await servicesData.deleteData(id, oldImage);

    if (response is Map<String, dynamic> && response['status'] == "success") {
      await getServicesData(); // Refresh the product list
      Get.snackbar(
        'Success',
        'service deleted successfully',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to delete service. Please try again.',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
    }

    statusRequest = StatusRequest.success; // Reset status
    update();
  }

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id')!;
    serviceName = TextEditingController();
    servicePrice = TextEditingController();
    serviceTime = TextEditingController();
    getServicesData();
    super.onInit();
  }
}
