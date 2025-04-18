import 'package:easycut_business/app.dart';
import 'package:easycut_business/controller/home/appointment_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Appointments extends StatelessWidget {
  const Appointments({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppointmentsControllerImp());
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
            text: "Appointments",
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
        body: GetBuilder<AppointmentsControllerImp>(
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: controller.appointment.saturday == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Add Appointments"),
                          Padding(
                            padding: EdgeInsets.all(
                              Dimensions.height15.h,
                            ),
                            child: CustomButtonAuth(
                              onPressed: () {
                                Get.offNamed(AppRoute.addAppointment);
                              },
                              text: "Add",
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height15.h),
                        child: Table(
                          border: TableBorder.all(),
                          children: [
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height15.h,
                                  ),
                                  child: const BigText(
                                    text: 'Day',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height15.h,
                                  ),
                                  child: const SmallText(
                                    text: "Start Time - End Time",
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Saturday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.saturday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Sunday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.sunday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Monday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.monday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Tuesday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.tuesday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Wednesday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.wednesday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Thursday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.thursday!,
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: const BigText(
                                    text: 'Friday',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.height10.h,
                                  ),
                                  child: SmallText(
                                    text: controller.appointment.friday!,
                                  ),
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
      ),
    );
  }
}
