import 'package:easycut_business/controller/home/booking_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:easycut_business/data/model/booking_model.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class BookingToday extends StatelessWidget {
  const BookingToday({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingControllerImp controller = Get.find<BookingControllerImp>();

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(AppRoute.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const BigText(
            text: "Booking Today",
            color: Colors.black,
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
              onPressed: () {
                _showAddBookingDialog(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: GetBuilder<BookingControllerImp>(
          init: controller,
          initState: (_) {
            controller.getBookingsData();
          },
          builder: (controller) {
            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: ListView.builder(
                itemCount: controller.bookingToday.length,
                itemBuilder: (context, index) {
                  final booking = controller.bookingToday[index];
                  return Container(
                    color: const Color.fromARGB(255, 215, 9, 9),
                    margin: EdgeInsets.all(Dimensions.height10.h),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height10.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: Dimensions.height45.r,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.height45.h),
                                child: booking.userImage != null &&
                                        booking.userImage!.isNotEmpty
                                    ? Image.network(
                                        "${AppLink.imageUsers}${booking.userImage}",
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.error,
                                            size: Dimensions.height45.h,
                                            color: Colors.red,
                                          );
                                        },
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: Dimensions.height45.h,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(width: Dimensions.width10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: booking.day ?? 'Unknown Day',
                                    size: Dimensions.font16.sp,
                                  ),
                                  BigText(
                                    text: booking.startTime ?? 'Unknown Time',
                                    size: Dimensions.font16.sp,
                                  ),
                                  BigText(
                                    text: booking.userName ?? 'Unknown User',
                                    size: Dimensions.font20.sp,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Dimensions.width10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SmallText(text: "Price:"),
                                    SizedBox(width: Dimensions.width5),
                                    BigText(
                                      text: "${booking.total ?? '0'} \$",
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
                                        color: booking.approve == 0
                                            ? Colors.orange
                                            : booking.approve == 1
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    DropdownButton<int>(
                                      value: booking.approve,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 0,
                                          child: Text("Waiting",
                                              style: TextStyle(
                                                  color: Colors.orange)),
                                        ),
                                        DropdownMenuItem(
                                          value: 1,
                                          child: Text("Accepted",
                                              style: TextStyle(
                                                  color: Colors.green)),
                                        ),
                                        DropdownMenuItem(
                                          value: 2,
                                          child: Text("Refused",
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                      onChanged: (newValue) {
                                        if (newValue != null &&
                                            booking.id != null) {
                                          controller.updateBookingStatus(
                                              booking.id.toString(), newValue);
                                          // Trigger UI update
                                          controller
                                              .update(); // This will notify GetX to update the UI
                                        }
                                      },
                                    )
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

  void _showAddBookingDialog(BuildContext context) {
    final BookingControllerImp controller = Get.find<BookingControllerImp>();

    TextEditingController dayController = TextEditingController();
    TextEditingController timeController = TextEditingController();
    TextEditingController userNameController = TextEditingController();
    TextEditingController totalController = TextEditingController();

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        dayController.text = "${picked.toLocal()}".split(' ')[0];
      }
    }

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        timeController.text = picked.format(context);
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dayController,
                decoration: const InputDecoration(
                  hintText: 'Day',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => selectDate(context),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  hintText: 'Start Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => selectTime(context),
              ),
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(hintText: 'User Name'),
              ),
              TextField(
                controller: totalController,
                decoration: const InputDecoration(hintText: 'Total'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String bookingId = prefs.getString('id') ?? '';
                  BookingModel newBooking = BookingModel(
                    id: int.parse(bookingId),
                    day: dayController.text,
                    startTime: timeController.text,
                    userName: userNameController.text,
                    total: int.parse(totalController.text),
                    approve: 0, // Default to not approved
                    userImage: null,
                  );

                  // Add the booking
                  await controller.addBooking(newBooking);

                  // Refresh the booking data
                  controller.getBookingsData();

                  // Notify GetX to rebuild the UI
                  controller.update();

                  // Schedule notification if needed
                  DateTime scheduledTime =
                      DateTime.now().add(const Duration(seconds: 5));

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  print(e);
                }
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }
}
