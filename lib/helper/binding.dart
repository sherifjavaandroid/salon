import 'package:easycut_business/controller/auth/forget_password_controller.dart';
import 'package:easycut_business/controller/auth/login_controller.dart';
import 'package:easycut_business/controller/auth/reset_password_controller.dart';
import 'package:easycut_business/controller/home/home_controller.dart';
import 'package:easycut_business/controller/onboarding_controller.dart';
import 'package:easycut_business/core/class/crud.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // ============== CRUD Operations
    Get.put(Crud());
    // ============== On Boarding Controller
    Get.lazyPut(() => OnBoardingControllerImp(), fenix: true);
    // ============== Auth Controller
    Get.lazyPut(() => LoginControllerImp(), fenix: true);
    Get.lazyPut(() => ForgetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => ResetPasswordControllerImp(), fenix: true);
    // ============== Home Controller
    Get.lazyPut(() => HomeControllerImp(), fenix: true);
    // Get.lazyPut(() => ProfileControllerImp(), fenix: true);
    // ============== Main Controller
    // Get.lazyPut(() => SalonDetailControllerImp());
  }
}
