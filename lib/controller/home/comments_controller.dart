import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/data_source/remote/home/comment_data.dart';
import 'package:easycut_business/data/model/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CommentsController extends GetxController {
  getCommentsData();
}

class CommentsControllerImp extends CommentsController {
  String? salonId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  CommentData commentData = CommentData(Get.find());
  List<CommentModel> comments = [];

  @override
  getCommentsData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await commentData.postData(
      salonId!,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        data.forEach((element) {
          var item = element as Map<String, dynamic>;
          comments.add(CommentModel.fromJson(item));
        });
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

  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id');
    getCommentsData();
    super.onInit();
  }
}
