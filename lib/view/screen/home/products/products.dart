import 'dart:io';

import 'package:easycut_business/controller/home/products_controller.dart';
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

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductsControllerImp());
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
            text: "Products",
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
                Get.offNamed(AppRoute.addProducts);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<ProductsControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.products.length,
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
                            CircleAvatar(
                              radius: Dimensions.height45.r,
                              child: ClipRRect(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.height45.r,
                                ),
                                child: Image.network(
                                  "${AppLink.imageProducts}${controller.products[index].image}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width10.w,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: controller.products[index].name!,
                                    size: Dimensions.font20.sp,
                                  ),
                                  BigText(
                                    text:
                                        "Number: ${controller.products[index].number}",
                                    size: Dimensions.font20.sp,
                                    color: Colors.red,
                                  ),
                                  SmallText(
                                    text:
                                        "Price: ${controller.products[index].price}",
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
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, ProductsControllerImp controller, int index) async {
    bool confirm = await Get.defaultDialog<bool>(
          title: "Confirm Delete",
          middleText: "Are you sure you want to delete this product?",
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
      await controller.productsData.deleteData(
        controller.products[index].id!.toString(),
        controller.products[index].image!,
      );

      // Refresh products data and UI after deletion
      await controller.getProductsData();

      // Optionally show a success message
      Get.snackbar("Success", "Product deleted successfully!",
          snackPosition: SnackPosition.BOTTOM);

      // No need to close dialog here as the delete is directly triggered
    }
  }

  void _showEditDialog(
      BuildContext context, ProductsControllerImp controller, int index) {
    controller.productName.text = controller.products[index].name!;
    controller.productPrice.text =
        controller.products[index].price!.toString(); // Ensure this is a string
    controller.productNumber.text = controller.products[index].number!
        .toString(); // Ensure this is a string

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
          title: const Text("Edit product"),
          content: Form(
            key: controller.formState,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.productName,
                  decoration: const InputDecoration(labelText: "product Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productPrice,
                  decoration: const InputDecoration(labelText: "product Price"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: controller.productNumber,
                  decoration: const InputDecoration(labelText: "product Time"),
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
              onPressed: () async {
                if (controller.formState.currentState!.validate()) {
                  if (controller.myFile != null) {
                    await controller.editProductData(
                      controller.products[index].id!
                          .toString(), // Convert id to string
                      controller.productName.text,
                      controller.productPrice.text,
                      controller.productNumber.text,
                      controller.myFile!, // Pass the selected file
                    );

                    // ignore: use_build_context_synchronously
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
