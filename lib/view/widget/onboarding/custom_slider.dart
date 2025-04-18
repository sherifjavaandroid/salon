import 'package:easycut_business/controller/onboarding_controller.dart';
import 'package:easycut_business/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            SizedBox(height: 80.h),
            Expanded(
              child: Image.asset(
                onBoardingList[i].image!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 80.h),
            Text(
              onBoardingList[i].title!,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 30.h),
              child: Text(
                onBoardingList[i].body!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}
