import 'package:easycut_business/app.dart';
import 'package:easycut_business/controller/home/booking_controller.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/features/home/notification/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize other services
  await initialServices();

  // Ensure screen size is initialized for Flutter ScreenUtil
  await ScreenUtil.ensureScreenSize();

  // Initialize timezone data

  // Setup notifications

  // Initialize GetX controller
  Get.put(BookingControllerImp());

  // Run the app
  runApp(const EasyCutBusiness());
}
