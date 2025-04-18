import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/data_source/remote/auth/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;
  bool isShowPassword = true;
  MyServices myServices = Get.find();

  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(email.text, password.text);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(
            'Congratulation',
            'You information is correct \nWait for loading Data.',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.green,
          );
          if (kDebugMode) {
            print(response.toString());
          }
          myServices.sharedPreferences
              .setString('id', response['data']['id'].toString());
          myServices.sharedPreferences
              .setString('name', response['data']['name']);
          myServices.sharedPreferences
              .setString('image', response['data']['image']);

          myServices.sharedPreferences.setString('step', '2');
          Get.offAllNamed(AppRoute.home);
        } else {
          Get.snackbar(
            'Warning',
            'Your information is incorrect',
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
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
