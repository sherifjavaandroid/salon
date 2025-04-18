import 'dart:convert';

import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class CustomersController extends GetxController {
  getCustomersData();
}

class CustomersControllerImp extends CustomersController {
  late String salonId;
  StatusRequest statusRequest = StatusRequest.success;
  List<CustomerModel> customers = [];
  String? username;
  MyServices myServices = Get.find();

  @override
  getCustomersData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      // Directly connecting to the API
      final response = await http.get(
        Uri.parse(
            'https://easycuteg.com/salons/booking/view.php?salonid=$salonId'),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        statusRequest =
            handlingData(responseData); // Handle your response status
        if (statusRequest == StatusRequest.success) {
          if (responseData['status'] == 'success') {
            // Extract customer data
            List data = responseData['data'] as List;

            // Use a Set to filter out duplicate usernames
            Set<String> uniqueUsernames = {};
            customers
                .clear(); // Clear the existing customer list before populating it

            for (var item in data) {
              var customer = CustomerModel.fromJson(item);
              if (uniqueUsernames.add(customer.name!)) {
                customers.add(customer);
              }
            }

            // Optionally set the first username found if needed
            if (customers.isNotEmpty) {
              username = customers.first.name; // Get the first unique username
            }
          } else {
            Get.snackbar(
              'Warning'.tr,
              'There is no data'.tr,
              snackPosition: SnackPosition.TOP,
              colorText: Colors.red,
            );
            statusRequest = StatusRequest.failure;
          }
        }
      } else {
        Get.snackbar(
          'Error'.tr,
          'Failed to load data'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id')!;
    getCustomersData();
    super.onInit();
  }
}
