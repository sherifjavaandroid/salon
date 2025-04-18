import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {
  initialData();
  logout();
}

class HomeControllerImp extends HomeController {
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  String? id;
  String? name;
  String? image;

  @override
  initialData() {
    id = myServices.sharedPreferences.getString('id');
    name = myServices.sharedPreferences.getString('name');
    image = myServices.sharedPreferences.getString('image');
  }

  @override
  logout() async {
    statusRequest = StatusRequest.loading;
    update();
    Get.offAllNamed(AppRoute.login);
    myServices.sharedPreferences.setString('id', '');
    myServices.sharedPreferences.setString('name', '');
    myServices.sharedPreferences.setString('image', '');

    myServices.sharedPreferences.setString('step', '1');

    update();
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
