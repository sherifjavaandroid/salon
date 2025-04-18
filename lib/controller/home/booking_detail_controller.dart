import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/data_source/remote/home/bookings_data.dart';
import 'package:easycut_business/data/model/booking_model.dart';
import 'package:easycut_business/data/model/services_model.dart';
import 'package:get/get.dart';

abstract class BookingDetailController extends GetxController {
  getBookingDetailData();
}

class BookingDetailControllerImp extends BookingDetailController {
  late String salonId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  BookingsData bookingsData = BookingsData(Get.find());
  late BookingModel bookingModel;
  List<ServicesModel> services = [];

  @override
  getBookingDetailData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await bookingsData.showServices(
      bookingModel.approve.toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'] as List;
        for (var element in data) {
          var item = element as Map<String, dynamic>;
          services.add(ServicesModel.fromJson(item));
        }
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id')!;
    bookingModel = Get.arguments['booking'];
    getBookingDetailData();
    super.onInit();
  }
}
