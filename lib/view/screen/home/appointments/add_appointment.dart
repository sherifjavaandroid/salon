import 'package:easycut_business/controller/home/appointment_controller.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAppointment extends StatelessWidget {
  const AddAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppointmentsControllerImp());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: BigText(
          text: "Add Appointments",
        ),
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRoute.appointment);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<AppointmentsControllerImp>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(Dimensions.height15),
            child: Column(
              children: [
                SelectTimeForDay(
                  day: "Saturday",
                  startTime: controller.startTimeSat,
                  endTime: controller.endTimeSat,
                  startTimeChange: (value) {
                    controller.changeStartTimeSat(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeSat(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Sunday",
                  startTime: controller.startTimeSun,
                  endTime: controller.endTimeSun,
                  startTimeChange: (value) {
                    controller.changeStartTimeSun(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeSun(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Monday",
                  startTime: controller.startTimeMon,
                  endTime: controller.endTimeMon,
                  startTimeChange: (value) {
                    controller.changeStartTimeMon(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeMon(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Tuesday",
                  startTime: controller.startTimeTue,
                  endTime: controller.endTimeTue,
                  startTimeChange: (value) {
                    controller.changeStartTimeTue(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeTue(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Wednesday",
                  startTime: controller.startTimeWed,
                  endTime: controller.endTimeWed,
                  startTimeChange: (value) {
                    controller.changeStartTimeWed(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeWed(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Thursday",
                  startTime: controller.startTimeThu,
                  endTime: controller.endTimeThu,
                  startTimeChange: (value) {
                    controller.changeStartTimeThu(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeThu(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SelectTimeForDay(
                  day: "Friday",
                  startTime: controller.startTimeFri,
                  endTime: controller.endTimeFri,
                  startTimeChange: (value) {
                    controller.changeStartTimeFri(value!);
                  },
                  endTimeChange: (value) {
                    controller.changeEndTimeFri(value!);
                  },
                ),
                SizedBox(height: Dimensions.height10),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonAuth(
                    onPressed: () {
                      controller.addAppointmentsData();
                    },
                    text: "Add",
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SelectTimeForDay extends StatelessWidget {
  const SelectTimeForDay({
    super.key,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.startTimeChange,
    required this.endTimeChange,
  });

  final String day;
  final String startTime;
  final String endTime;
  final void Function(String?) startTimeChange;
  final void Function(String?) endTimeChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height60,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
          left: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
          right: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
          bottom: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              SizedBox(
                width: constraints.maxWidth / 3.7,
                child: BigText(
                  text: day,
                  size: Dimensions.font16,
                ),
              ),
              SizedBox(
                width: constraints.maxWidth / 2.75,
                child: Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(width: Dimensions.width5),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.primaryColor,
                        ),
                        underline: const SizedBox(),
                        value: startTime,
                        items: [
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "9:00 AM",
                            onTap: () {},
                            child: const SmallText(
                              text: '9:00 AM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "10:00 AM",
                            onTap: () {},
                            child: const SmallText(
                              text: '10:00 AM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.male,
                            value: "11:00 AM",
                            onTap: () {},
                            child: const SmallText(
                              text: '11:00 AM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.female,
                            value: "12:00 AM",
                            onTap: () {},
                            child: const SmallText(
                              text: '12:00 AM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "REST",
                            onTap: () {},
                            child: const SmallText(
                              text: 'REST',
                            ),
                          ),
                        ],
                        onChanged: startTimeChange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constraints.maxWidth / 2.75,
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(width: Dimensions.width5),
                    Expanded(
                      child: DropdownButton(
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColor.primaryColor,
                        ),
                        underline: const SizedBox(),
                        value: endTime,
                        items: [
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "9:00 PM",
                            onTap: () {},
                            child: const SmallText(
                              text: '9:00 PM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "10:00 PM",
                            onTap: () {},
                            child: const SmallText(
                              text: '10:00 PM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.male,
                            value: "11:00 PM",
                            onTap: () {},
                            child: const SmallText(
                              text: '11:00 PM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.female,
                            value: "12:00 PM",
                            onTap: () {},
                            child: const SmallText(
                              text: '12:00 PM',
                            ),
                          ),
                          DropdownMenuItem(
                            // value: Gender.gender,
                            value: "REST",
                            onTap: () {},
                            child: const SmallText(
                              text: 'REST',
                            ),
                          ),
                        ],
                        onChanged: endTimeChange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
