import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/image_asset.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/data/model/home_text.dart';
import 'package:easycut_business/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    title: "5".tr,
    body: "6".tr,
    image: AppImageAsset.salonOne,
  ),
  OnBoardingModel(
    title: "7".tr,
    body: "8".tr,
    image: AppImageAsset.salonTwo,
  ),
  OnBoardingModel(
    title: "9".tr,
    body: "10".tr,
    image: AppImageAsset.salonThree,
  ),
  OnBoardingModel(
    title: "11".tr,
    body: "12".tr,
    image: AppImageAsset.salonFour,
  ),
];

List<HomeText> mainHome = [
  // Add a new item to the mainHome list in lib/data/data_source/static/static.dart

  HomeText(
    title: "Dashboard",
    icon: Icons.dashboard,
    color: Colors.purple,
    taped: () {
      Get.offNamed(AppRoute.dashboard);
    },
  ),

  HomeText(
    title: "Booking Today",
    icon: Icons.calendar_today,
    color: Colors.red,
    taped: () {
      Get.offNamed(AppRoute.bookingToday);
    },
  ),
  HomeText(
    title: "Booking Pending",
    icon: Icons.edit_calendar,
    color: AppColor.primaryColor,
    taped: () {
      Get.offNamed(AppRoute.bookingPending);
    },
  ),
  HomeText(
    title: "All Bookings",
    icon: Icons.calendar_month,
    color: AppColor.primaryColor,
    taped: () {
      Get.offNamed(AppRoute.allBooking);
    },
  ),
  HomeText(
    title: "Appointments",
    icon: Icons.calendar_view_month,
    color: Colors.red,
    taped: () {
      Get.offNamed(AppRoute.appointment);
    },
  ),
  HomeText(
    title: "Customers",
    icon: Icons.person,
    color: Colors.red,
    taped: () {
      Get.offNamed(AppRoute.customers);
    },
  ),
  HomeText(
    title: "Services",
    icon: Icons.design_services,
    color: AppColor.primaryColor,
    taped: () {
      Get.offNamed(AppRoute.services);
    },
  ),
  HomeText(
    title: "Products",
    icon: Icons.shopping_basket,
    color: AppColor.primaryColor,
    taped: () {
      Get.offNamed(AppRoute.products);
    },
  ),
  HomeText(
    title: "Profile",
    icon: Icons.settings,
    color: Colors.red,
    taped: () {
      Get.offNamed(AppRoute.salonProfile);
    },
  ),
];
