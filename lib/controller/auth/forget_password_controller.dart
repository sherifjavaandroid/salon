import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/data/data_source/remote/forget_password/check_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  checkEmail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  CheckEmailData checkEmailData = CheckEmailData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  @override
  checkEmail() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await checkEmailData.postData(
        email.text,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(
            'Email Found',
            'Change your Password Now',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.green,
          );
          Get.offNamed(AppRoute.resetPassword, arguments: {
            'email': email.text,
          });
        } else {
          Get.snackbar(
            'Warning',
            'Email is not found',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
