import 'package:easycut_business/app.dart';
import 'package:easycut_business/controller/onboarding_controller.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              onBoardingList.length,
              (index) {
                return AnimatedContainer(
                  margin: EdgeInsets.only(right: 5.w),
                  duration: const Duration(milliseconds: 600),
                  width: controller.currentPage == index ? 20.w : 5.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: controller.currentPage == index
                        ? AppColor.primaryColor
                        : AppColor.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
