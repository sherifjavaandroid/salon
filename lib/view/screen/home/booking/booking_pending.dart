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

class BookingPending extends StatefulWidget {
  const BookingPending({super.key});

  @override
  State<BookingPending> createState() => _BookingPendingState();
}

class _BookingPendingState extends State<BookingPending> {
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
            text: "Booking Pending",
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
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                // Call the refresh method to update the booking data
                Get.find<BookingControllerImp>().refreshBookingData();
              },
            ),
          ],
        ),
        body: GetBuilder<BookingControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.bookingPending.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // controller.goToPendingBookingDetail(
                      //     controller.bookingPending[index]);
                    },
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.height10.h, vertical: 4.w),
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height10.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    height: 60.h,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(200.r),
                                      child: Image.network(
                                        "${AppLink.imageUsers}${controller.bookingPending[index].userImage}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: controller
                                              .bookingPending[index].day!,
                                          size: Dimensions.font16.sp,
                                        ),
                                        BigText(
                                          text: controller
                                              .bookingPending[index].startTime!,
                                          size: Dimensions.font16.sp,
                                          color: Colors.red,
                                        ),
                                        BigText(
                                          text: controller
                                              .bookingPending[index].userName!,
                                          size: Dimensions.font20.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SmallText(text: "Price :"),
                                          SizedBox(width: Dimensions.width5.w),
                                          BigText(
                                            text:
                                                "${controller.bookingPending[index].total!} \$",
                                            size: Dimensions.font16.sp,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 15.h,
                                            width: 15.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: controller
                                                          .bookingPending[index]
                                                          .approve ==
                                                      0
                                                  ? Colors.orange
                                                  : controller
                                                              .bookingPending[
                                                                  index]
                                                              .approve ==
                                                          1
                                                      ? Colors.green
                                                      : Colors.red,
                                            ),
                                          ),
                                          SizedBox(width: 5.w, height: 20.h),
                                          DropdownButton<int>(
                                            value: controller
                                                .bookingPending[index].approve,
                                            items: const [
                                              DropdownMenuItem(
                                                value: 0,
                                                child: Text(
                                                  "Waiting",
                                                  style: TextStyle(
                                                      color: Colors.orange),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 1,
                                                child: Text(
                                                  "Accepted",
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 2,
                                                child: Text(
                                                  "Refused",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                            onChanged: (newValue) async {
                                              if (newValue != null) {
                                                setState(() {
                                                  controller
                                                      .bookingPending[index]
                                                      .approve = newValue;
                                                });
                                                await controller
                                                    .updateBookingStatus(
                                                  controller
                                                      .bookingPending[index].id
                                                      .toString(),
                                                  newValue,
                                                );
                                                controller.update();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
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
