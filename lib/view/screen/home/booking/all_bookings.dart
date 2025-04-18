import 'package:easycut_business/controller/home/booking_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllBookings extends StatelessWidget {
  const AllBookings({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BookingControllerImp());
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
            text: "All Booking",
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
        body: GetBuilder<BookingControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.allBookings.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100.h,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.height10.h, vertical: 4.w),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height10.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100.w,
                              height: 150.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  Dimensions.height45.r,
                                ),
                                child:
                                    controller.allBookings[index].userImage !=
                                                null &&
                                            controller.allBookings[index]
                                                .userImage!.isNotEmpty
                                        ? Image.network(
                                            "${AppLink.imageUsers}${controller.allBookings[index].userImage}",
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
                                    text: controller.allBookings[index].day!,
                                    size: Dimensions.font16.sp,
                                  ),
                                  BigText(
                                    text: controller
                                        .allBookings[index].startTime!,
                                    size: Dimensions.font16.sp,
                                    color: Colors.red,
                                  ),
                                  BigText(
                                    text:
                                        controller.allBookings[index].userName!,
                                    size: Dimensions.font16.sp,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SmallText(text: "Price :"),
                                    SizedBox(width: Dimensions.width5.w),
                                    BigText(
                                      text:
                                          "${controller.allBookings[index].total!} \$",
                                      size: Dimensions.font16.sp,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: Dimensions.height15.h,
                                      width: Dimensions.height15.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: controller.allBookings[index]
                                                    .approve ==
                                                0
                                            ? Colors.orange
                                            : controller.allBookings[index]
                                                        .approve ==
                                                    1
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width5),
                                    BigText(
                                      text: controller
                                                  .allBookings[index].approve ==
                                              0
                                          ? "waiting"
                                          : controller.allBookings[index]
                                                      .approve ==
                                                  1
                                              ? "accepted"
                                              : "refused",
                                      size: Dimensions.font16,
                                      color: controller
                                                  .allBookings[index].approve ==
                                              0
                                          ? Colors.orange
                                          : controller.allBookings[index]
                                                      .approve ==
                                                  1
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ],
                                ),
                              ],
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
}
