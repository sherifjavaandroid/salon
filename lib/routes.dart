import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/middleware/my_middleware.dart';
import 'package:easycut_business/routes.dart' show dashboard;
import 'package:easycut_business/view/screen/auth/forget_password/forgot_password.dart';
import 'package:easycut_business/view/screen/auth/forget_password/reset_password.dart';
import 'package:easycut_business/view/screen/auth/login.dart';
import 'package:easycut_business/view/screen/auth/success.dart';
import 'package:easycut_business/view/screen/home.dart';
import 'package:easycut_business/view/screen/home/appointments/add_appointment.dart';
import 'package:easycut_business/view/screen/home/appointments/appointment.dart';
import 'package:easycut_business/view/screen/home/booking/all_bookings.dart';
import 'package:easycut_business/view/screen/home/booking/bookind_detail.dart';
import 'package:easycut_business/view/screen/home/booking/booking_pending.dart';
import 'package:easycut_business/view/screen/home/booking/booking_today.dart';
import 'package:easycut_business/view/screen/home/customers/customers.dart';
import 'package:easycut_business/view/screen/home/dashboard/dashboard_statistics.dart';
import 'package:easycut_business/view/screen/home/products/add_product.dart';
import 'package:easycut_business/view/screen/home/products/products.dart';
import 'package:easycut_business/view/screen/home/profile/edit_profile.dart';
import 'package:easycut_business/view/screen/home/profile/profile.dart';
import 'package:easycut_business/view/screen/home/services/add_services.dart';
import 'package:easycut_business/view/screen/home/services/services.dart';
import 'package:easycut_business/view/screen/language.dart';
import 'package:easycut_business/view/screen/onboarding.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? routes = [
  // =================== On Boarding ======================
  GetPage(
    name: "/",
    page: () => const Language(),
    middlewares: [
      MyMiddleware(),
    ],
  ),

// Modifications to add to lib/routes.dart

// Add this to the AppRoute class


// Add this to the routes list
GetPage(
name: AppRoute.dashboard,
page: () => const DashboardStatistics(),
),

  GetPage(
    name: AppRoute.onBoarding,
    page: () => const OnBoarding(),
  ),
  // ===================     Auth    ======================
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
  ),
  GetPage(
    name: AppRoute.forgetPassword,
    page: () => const ForgotPassword(),
  ),
  GetPage(
    name: AppRoute.resetPassword,
    page: () => const ResetPassword(),
  ),
  GetPage(
    name: AppRoute.success,
    page: () => const Success(),
  ),
  // ===================     Home =========================
  GetPage(
    name: AppRoute.home,
    page: () => const Home(),
  ),
  GetPage(
    name: AppRoute.bookingToday,
    page: () => const BookingToday(),
  ),
  GetPage(
    name: AppRoute.bookingPending,
    page: () => const BookingPending(),
  ),
  GetPage(
    name: AppRoute.allBooking,
    page: () => const AllBookings(),
  ),
  GetPage(
    name: AppRoute.appointment,
    page: () => const Appointments(),
  ),
  GetPage(
    name: AppRoute.addAppointment,
    page: () => const AddAppointment(),
  ),
  GetPage(
    name: AppRoute.customers,
    page: () => const Customers(),
  ),
  GetPage(
    name: AppRoute.services,
    page: () => const Services(),
  ),
  GetPage(
    name: AppRoute.addServices,
    page: () => const AddServices(),
  ),
  GetPage(
    name: AppRoute.products,
    page: () => const Products(),
  ),
  GetPage(
    name: AppRoute.addProducts,
    page: () => const AddProduct(),
  ),
  GetPage(
    name: AppRoute.salonProfile,
    page: () => const ProfileView(),
  ),
  GetPage(
    name: AppRoute.salonProfileEdit,
    page: () => const EditProfile(),
  ),
  GetPage(
    name: AppRoute.bookingDetail,
    page: () => const BookingDetail(),
  ),
];
