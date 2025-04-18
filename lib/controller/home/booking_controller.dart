import 'package:easycut_business/core/class/status_request.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/services/services.dart';
import 'package:easycut_business/data/model/booking_model.dart';
import 'package:easycut_business/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

abstract class BookingController extends GetxController {
  Future<void> getBookingsData();
  void goToPendingBookingDetail(BookingModel bookingModel);
  Future<void> addBooking(BookingModel booking);
  Future<void> loadBookings();
  void updateBookingStatus(String id, int newValue);
}

class BookingControllerImp extends BookingController {
  late String salonId;
  final MyServices myServices = Get.find();
  Timer? _bookingRefreshTimer;

  final RxList<BookingModel> allBookings = <BookingModel>[].obs;
  final RxList<BookingModel> bookingPending = <BookingModel>[].obs;
  final RxList<BookingModel> bookingToday = <BookingModel>[].obs;

  StatusRequest statusRequest = StatusRequest.success;
  List bookings =
      []; // Define this at the class level to avoid the undefined error

  @override
  @override
  void onInit() {
    salonId = myServices.sharedPreferences.getString('id') ?? '26';
    getBookingsData();

    // Set up a periodic timer to fetch bookings data every 10 seconds
    _bookingRefreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getBookingsData();
    });

    super.onInit();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is closed to prevent memory leaks
    _bookingRefreshTimer?.cancel();
    super.onClose();
  }

  @override
  Future<void> getBookingsData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      // Get the initial count of pending bookings
      int initialPendingCount = bookingPending.length;

      await loadBookings(); // Load all bookings
      _filterBookingsByToday(); // Filter today's bookings
      _filterPendingBookings(); // Filter pending bookings

      // Check if there are new pending bookings
      if (bookingPending.length > initialPendingCount) {
        _showPendingBookingNotification(); // Show notification for new pending bookings
      }

      statusRequest = StatusRequest.success;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bookings: $e');
      }
      statusRequest = StatusRequest.error;
    }

    update();
  }

// Function to display the notification for new pending bookings
  void _showPendingBookingNotification() {
    flutterLocalNotificationsPlugin.show(
      0,
      'New Pending Bookings',
      'There are new pending bookings to review.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'pending_channel_id',
          'Pending Bookings',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  Future<void> loadBookings() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      salonId = prefs.getString('id') ?? '';

      final url = Uri.parse(
          'https://easycuteg.com/salons/booking/view.php?salonid=$salonId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data')) {
          final List<dynamic> data = responseBody['data'];

          allBookings.value = data.map((json) {
            try {
              return BookingModel.fromJson(json);
            } catch (e) {
              if (kDebugMode) {
                print('Error parsing booking data: $e');
              }
              return BookingModel(id: int.parse(salonId));
            }
          }).toList();

          _filterBookingsByToday();
          _filterPendingBookings();
        } else {
          throw Exception('No data found in response');
        }
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading bookings: $e');
      }
    }
  }

  @override
  Future<void> addBooking(BookingModel booking) async {
    try {
      final url = Uri.parse('https://easycuteg.com/booking/add_custom.php');

      final requestData = {
        'salonid':
            salonId, // Salon ID from SharedPreferences or provided earlier
        'username': booking.userName,
        'day': booking.day,
        'starttime': booking.startTime,
        //  'endtime': booking.endTime, // Ensure endTime is included
        'total': booking.total.toString(),
      };

      if (kDebugMode) {
        print("Sending booking data: $requestData");
      }

      final response = await http.post(
        url,
        body: requestData,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == 'success') {
          if (kDebugMode) {
            print('Booking added successfully: $responseBody');
          }

          // Add the booking to the observable list, which will update the UI
          allBookings.add(booking);
          _filterBookingsByToday(); // Refresh today bookings
          update(); // Notify listeners of the update

          // Optionally, display a success message
          Get.snackbar('Success', 'Booking added successfully!');
        } else {
          if (kDebugMode) {
            print("API Error: ${responseBody['message']}");
          }
          Get.snackbar(
              'Error', 'Failed to add booking: ${responseBody['message']}');
        }
      } else {
        if (kDebugMode) {
          print("API Error: ${response.statusCode}");
        }
        throw Exception('Failed to add booking');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding booking: $e');
      }
      Get.snackbar('Error', 'Error adding booking: $e');
    }
  }

  @override
  Future<void> updateBookingStatus(String id, int newValue) async {
    try {
      final url = Uri.parse('https://easycuteg.com/salons/booking/edit.php');

      final requestData = {
        'id': id,
        'approve': newValue.toString(),
        'status': '1',
      };

      if (kDebugMode) {
        print("Sending request data: $requestData");
      }

      // Step 1: Update in your server
      final response = await http.post(
        url,
        body: requestData,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      // if (response.statusCode == 200) {
      //   final updatedBooking = json.decode(response.body);

      //   if (updatedBooking['status'] == 'success') {
      //     // Step 2: Update the value in Firebase Firestore
      //     await FirebaseFirestore.instance
      //         .collection('bookings') // Your Firebase collection name
      //         .doc(id) // Document ID for the booking in Firebase
      //         .update({'approve': newValue});

      //     // Update the booking in local state
      //     final int index =
      //         allBookings.indexWhere((booking) => booking.id == int.parse(id));
      //     if (index != -1) {
      //       allBookings[index].approve = newValue;
      //       _filterBookingsByToday();
      //       _filterPendingBookings();
      //       update();
      //     }

      //     print('Booking status updated successfully in Firebase and server.');
      //   } else {
      //     print("API Error: ${updatedBooking['message']}");
      //   }
      // } else {
      //   print("API Error: ${response.statusCode}");
      //   throw Exception('Failed to update booking status on server');
      // }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating booking status: $e');
      }
    }
  }

  @override
  void goToPendingBookingDetail(BookingModel bookingModel) {
    Get.offNamed(AppRoute.bookingDetail, arguments: {
      "booking": bookingModel,
    });
  }

  @override
  // void onInit() {
  //   salonId = myServices.sharedPreferences.getString('id') ?? '26';
  //   getBookingsData();
  //   super.onInit();
  // }

  void _filterBookingsByToday() {
    final String todayDate =
        DateTime.now().toLocal().toString().substring(0, 10);
    bookingToday.value = allBookings
        .where((element) => element.day == todayDate && element.approve == 1)
        .toList();
  }

  void _filterPendingBookings() {
    bookingPending.value =
        allBookings.where((element) => element.approve == 0).toList();
  }

  Future<void> refreshBookingData() async {
    await getBookingsData(); // Fetch and refresh the bookings data
  }
}
