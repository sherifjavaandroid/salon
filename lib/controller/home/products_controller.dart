import 'dart:io';

import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/functions/handling_data_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/data/data_source/remote/home/products_data.dart';
import 'package:easycut_business/data/model/products_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProductsController extends GetxController {
  getProductsData();
  addProductsData();
}

class ProductsControllerImp extends ProductsController {
  late String salonId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  ProductsData productsData = ProductsData(Get.find());
  List<ProductModel> products = [];

  @override
  getProductsData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productsData.getData(
      salonId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        List data = response['data'];
        if (kDebugMode) {
          print(response);
        }
        products = data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController productName;
  late TextEditingController productNumber;
  late TextEditingController productPrice;
  File? myFile;

  void addFilePath(String path) {
    myFile = File(path);
    update();
  }

  // // Check if the product name already exists
  // bool isDuplicateName(String name, {String? excludedId}) {
  //   return products.any((product) =>
  //       product.name?.toLowerCase() == name.toLowerCase() &&
  //       product.id != excludedId); // Exclude the current product being edited
  // }

  @override
  addProductsData() async {
    if (myFile == null) {
      return Get.defaultDialog(
        title: "Warning",
        content: const SmallText(
          text: "You must upload an image for your Product",
        ),
      );
    }
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await productsData.postData(
        salonId,
        productName.text,
        productPrice.text,
        productNumber.text,
        myFile!,
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(
            'Success',
            'Product added successfully',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.green,
          );
          Get.offNamed(AppRoute.products);
        } else {
          statusRequest = StatusRequest.none;
        }
      }
      update();
    }
  }

  Future<void> editProductData(
      String id, String name, String price, String time, File image) async {
    var response = await productsData.editData(id, name, price, time, image, 1);

    if (response is Map<String, dynamic> && response['status'] == "success") {
      await getProductsData(); // Update UI
      Get.snackbar(
        'Success',
        'Product edited successfully',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
      update();
    } else if (response is StatusRequest) {
      if (kDebugMode) {
        print("Request failed with status: }");
      }
    } else {
      if (kDebugMode) {
        print("Failed to edit product: unexpected response format.");
      }
    }
  }

  // Method to delete a product
  Future<void> deleteProductData(String id, String oldImage) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productsData.deleteData(id, oldImage);

    if (response is Map<String, dynamic> && response['status'] == "success") {
      await getProductsData(); // Refresh the product list
      Get.snackbar(
        'Success',
        'Product deleted successfully',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.green,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to delete product. Please try again.',
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
    productName = TextEditingController();
    productPrice = TextEditingController();
    productNumber = TextEditingController();
    getProductsData();
    super.onInit();
  }
}
