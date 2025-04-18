import 'package:easycut_business/controller/home/customers_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CustomersControllerImp());
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
            text: "Customers",
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
        ),
        body: GetBuilder<CustomersControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.separated(
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 300.h,
                    width: double.infinity,
                    child: Card(
                      //margin: EdgeInsets.all(Dimensions.height15.h),
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 80.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.height20.h,
                                ),
                                child:
                                    controller.customers[index].image != null &&
                                            controller.customers[index].image!
                                                .isNotEmpty
                                        ? Image.network(
                                            "${AppLink.imageUsers}${controller.customers[index].image}",
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Fallback to a placeholder image from the internet on error
                                              return Image.network(
                                                'https://img.freepik.com/premium-photo/handsome-male-model-man-smiling-with-perfectly-clean-teeth-stock-photo-dental-background_592138-1188.jpg?w=2000', // Internet placeholder image
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.network(
                                            'https://img.freepik.com/premium-photo/handsome-male-model-man-smiling-with-perfectly-clean-teeth-stock-photo-dental-background_592138-1188.jpg?w=2000', // Internet placeholder image
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            // SizedBox(height: Dimensions.height10.h),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SmallText(text: "Name:"),
                                      SizedBox(
                                        width: Dimensions.width5.w,
                                      ),
                                      BigText(
                                        text: controller.customers[index].name!,
                                        color: AppColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10.h),
                                  Row(
                                    children: [
                                      const SmallText(text: "Email:"),
                                      SizedBox(
                                        width: 260.w,
                                        child: BigText(
                                          text: controller
                                              .customers[index].email!,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10.h),
                                  Row(
                                    children: [
                                      const SmallText(text: "Phone:"),
                                      SizedBox(
                                        width: Dimensions.width5.w,
                                      ),
                                      BigText(
                                        text:
                                            controller.customers[index].phone!,
                                        color: AppColor.primaryColor,
                                      ),
                                    ],
                                  ),

                                  ///SizedBox(height: Dimensions.height10.h),
                                  Row(
                                    children: [
                                      const SmallText(text: "Address:"),
                                      SizedBox(
                                        width: Dimensions.width5.w,
                                      ),
                                      BigText(
                                        text:
                                            "${controller.customers[index].country!} - ${controller.customers[index].city!} ${controller.customers[index].address!}",
                                        color: AppColor.primaryColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: Dimensions.height10.h,
                  );
                },
                itemCount: controller.customers.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
