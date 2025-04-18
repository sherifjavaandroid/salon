import 'dart:io';

import 'package:easycut_business/controller/home/services_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ServicesControllerImp());
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .pushReplacement(Get.offNamed(AppRoute.home) as Route<Object?>);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const BigText(
            text: "Services",
          ),
          leading: IconButton(
            onPressed: () {
              Get.offNamed(AppRoute.home);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.offNamed(AppRoute.addServices);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<ServicesControllerImp>(builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
              itemCount: controller.services.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100.h,
                  width: double.infinity,
                  margin: EdgeInsets.all(Dimensions.height10.h),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.height10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60.w,
                            height: 60.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100).r,
                              child: Image.network(
                                "${AppLink.imageServices}${controller.services[index].image}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.width10.w),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: controller.services[index].name!,
                                  size: Dimensions.font20.sp,
                                ),
                                BigText(
                                  text:
                                      "Price: ${controller.services[index].price}",
                                  size: Dimensions.font20.sp,
                                  color: Colors.red,
                                ),
                                SmallText(
                                  text:
                                      "Time: ${controller.services[index].time} min",
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showEditDialog(context, controller, index);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text("Edit"),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'delete') {
                                _showDeleteConfirmation(
                                    context, controller, index);
                              }
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text("delete"),
                              ),
                            ],
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }

  // // Method to show edit dialog
  void _showDeleteConfirmation(
      BuildContext context, ServicesControllerImp controller, int index) async {
    bool confirm = await Get.defaultDialog<bool>(
          title: "Confirm Delete",
          middleText: "Are you sure you want to delete this service?",
          textCancel: "No",
          textConfirm: "Yes",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(result: true);
          },
          onCancel: () {
            Get.back(result: false);
          },
        ) ??
        false;

    if (confirm) {
      await controller.servicesData.deleteData(
        controller.services[index].id!.toString(),
        controller.services[index].image!,
      );

      // Refresh products data and UI after deletion
      await controller.getServicesData();

      // Optionally show a success message
      Get.snackbar("Success", "service deleted successfully!",
          snackPosition: SnackPosition.BOTTOM);

      // No need to close dialog here as the delete is directly triggered
    }
  }

  void _showEditDialog(
      BuildContext context, ServicesControllerImp controller, int index) {
    controller.serviceName.text = controller.services[index].name!;
    controller.servicePrice.text =
        controller.services[index].price!.toString(); // Ensure this is a string
    controller.serviceTime.text =
        controller.services[index].time!.toString(); // Ensure this is a string

    // Method to pick an image from gallery or camera
    Future<void> pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        controller.myFile = File(pickedFile.path);
        controller.update(); // Refresh UI to show selected image
      } else {
        if (kDebugMode) {
          print("No image selected.");
        }
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Service"),
          content: Form(
            key: controller.formState,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.serviceName,
                  decoration: const InputDecoration(labelText: "Service Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.servicePrice,
                  decoration: const InputDecoration(labelText: "Service Price"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.serviceTime,
                  decoration: const InputDecoration(labelText: "Service Time"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a time";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                // Image picker button
                ElevatedButton(
                  onPressed: pickImage,
                  child: const Text("Select Image"),
                ),
                // Display the selected image preview
                controller.myFile != null
                    ? Image.file(controller.myFile!, height: 50.h, width: 50.w)
                    : const Text("No image selected"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.formState.currentState!.validate()) {
                  if (controller.myFile != null) {
                    controller.editServiceData(
                      controller.services[index].id!
                          .toString(), // Convert id to string
                      controller.serviceName.text,
                      controller.servicePrice.text,
                      controller.serviceTime.text,
                      controller.myFile!, // Pass the selected file
                    );
                    Navigator.of(context).pop(); // Close the dialog
                  } else {
                    Get.snackbar('Error', 'Please select a file');
                  }
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
