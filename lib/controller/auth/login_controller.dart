import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/data_source/remote/auth/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  loginWithEmail();
  loginWithPhone();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  // Tab Controller
  late TabController tabController;

  // Form Keys
  GlobalKey<FormState> emailFormState = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormState = GlobalKey<FormState>();

  // Email Login Controllers
  late TextEditingController email;
  late TextEditingController emailPassword;

  // Phone Login Controllers
  late TextEditingController phone;
  late TextEditingController countryCode;
  late TextEditingController phonePassword;

  // Data and Status
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  // Password Visibility
  bool isShowEmailPassword = true;
  bool isShowPhonePassword = true;

  MyServices myServices = Get.find();

  // Show/Hide Email Password
  showEmailPassword() {
    isShowEmailPassword = !isShowEmailPassword;
    update();
  }

  // Show/Hide Phone Password
  showPhonePassword() {
    isShowPhonePassword = !isShowPhonePassword;
    update();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }

  @override
  loginWithEmail() async {
    var formData = emailFormState.currentState;
    print(formData);
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      // Call login API with email
      var response = await loginData.postDataWithEmail(email.text, emailPassword.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        await _handleLoginResponse(response);
      }
      update();
    }
  }

  @override
  loginWithPhone() async {
    var formData = phoneFormState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      // Call login API with phone
      var response = await loginData.postDataWithPhone(phone.text, countryCode.text, phonePassword.text);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        await _handleLoginResponse(response);
      }
      update();
    }
  }

  // Common method to handle login response
  Future<void> _handleLoginResponse(Map response) async {
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

      // Save user data to SharedPreferences
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

  @override
  void onInit() {
    // Initialize Tab Controller
    tabController = TabController(length: 2, vsync: this);

    // Add listener to update UI when tab changes
    tabController.addListener(() {
      update();
    });

    // Initialize Email Controllers
    email = TextEditingController();
    emailPassword = TextEditingController();

    // Initialize Phone Controllers
    phone = TextEditingController();
    countryCode = TextEditingController(text: "+20");
    phonePassword = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    // Dispose Tab Controller
    tabController.dispose();

    // Dispose Email Controllers
    email.dispose();
    emailPassword.dispose();

    // Dispose Phone Controllers
    phone.dispose();
    countryCode.dispose();
    phonePassword.dispose();

    super.dispose();
  }
}