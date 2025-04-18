import 'package:easycut_business/controller/home/booking_controller.dart';
import 'package:easycut_business/core/class/handling_data_view.dart';
import 'package:easycut_business/core/constant/color.dart';
import 'package:easycut_business/core/constant/dimensions.dart';
import 'package:easycut_business/core/constant/routes.dart';
import 'package:easycut_business/core/shared/widgets/big_text.dart';
import 'package:easycut_business/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardStatistics extends StatefulWidget {
  const DashboardStatistics({Key? key}) : super(key: key);

  @override
  State<DashboardStatistics> createState() => _DashboardStatisticsState();
}

class _DashboardStatisticsState extends State<DashboardStatistics> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BookingControllerImp controller = Get.find<BookingControllerImp>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    controller.getBookingsData(); // Ensure we have fresh data
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(AppRoute.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const BigText(
            text: "Dashboard",
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
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                controller.refreshBookingData();
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: AppColor.primaryColor,
            unselectedLabelColor: AppColor.grey,
            tabs: const [
              Tab(text: "Daily"),
              Tab(text: "Weekly"),
              Tab(text: "Monthly"),
            ],
          ),
        ),
        body: GetBuilder<BookingControllerImp>(
          builder: (bookingController) {
            return HandlingDataView(
              statusRequest: bookingController.statusRequest,
              widget: Column(
                children: [
                  // Summary Cards
                  buildSummaryCards(bookingController),

                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Daily View
                        buildDailyView(bookingController),

                        // Weekly View
                        buildWeeklyView(bookingController),

                        // Monthly View
                        buildMonthlyView(bookingController),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSummaryCards(BookingControllerImp bookingController) {
    // Calculate total profit from all bookings
    double totalProfit = bookingController.allBookings
        .map((booking) => booking.total ?? 0)
        .fold(0, (prev, amount) => prev + amount);

    // Count total bookings
    int totalBookings = bookingController.allBookings.length;

    // Count today's bookings
    int todayBookings = bookingController.bookingToday.length;

    // Get pending bookings count
    int pendingBookings = bookingController.bookingPending.length;

    return Padding(
      padding: EdgeInsets.all(Dimensions.height15.h),
      child: Column(
        children: [
          Row(
            children: [
              // Total Bookings Card
              Expanded(
                child: _buildStatCard(
                  "Total Bookings",
                  totalBookings.toString(),
                  const Color(0xFF4A90E2),
                  Icons.calendar_today,
                ),
              ),
              SizedBox(width: Dimensions.width10.w),
              // Total Profit Card
              Expanded(
                child: _buildStatCard(
                  "Total Profit",
                  "$totalProfit \$",
                  const Color(0xFF50C878),
                  Icons.monetization_on,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10.h),
          Row(
            children: [
              // Today's Bookings Card
              Expanded(
                child: _buildStatCard(
                  "Today's Bookings",
                  todayBookings.toString(),
                  const Color(0xFFFFA500),
                  Icons.today,
                ),
              ),
              SizedBox(width: Dimensions.width10.w),
              // Pending Bookings Card
              Expanded(
                child: _buildStatCard(
                  "Pending Bookings",
                  pendingBookings.toString(),
                  const Color(0xFFE74C3C),
                  Icons.pending_actions,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color, IconData icon) {
    return Container(
      height: Dimensions.height100.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.radius15.r),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: Dimensions.height30.h),
          SizedBox(height: Dimensions.height15.h),
          SmallText(
            text: title,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: Dimensions.height15.h),
          BigText(
            text: value,
            color: color,
            size: Dimensions.font20.sp,
          ),
        ],
      ),
    );
  }

  Widget buildDailyView(BookingControllerImp bookingController) {
    // Group bookings by hour for today
    final DateTime today = DateTime.now();
    final String todayString = today.toString().substring(0, 10);

    // Get only today's bookings
    final todayBookings = bookingController.allBookings
        .where((booking) => booking.day == todayString)
        .toList();

    // Create a map to hold bookings per hour
    Map<int, int> bookingsByHour = {};
    Map<int, double> profitByHour = {};

    // Initialize hours (0-23)
    for (int i = 0; i < 24; i++) {
      bookingsByHour[i] = 0;
      profitByHour[i] = 0;
    }

    // Count bookings per hour
    for (var booking in todayBookings) {
      if (booking.startTime != null) {
        // Extract hour from startTime (assuming format like "3:00 PM")
        int hour = _extractHourFromTimeString(booking.startTime!);
        bookingsByHour[hour] = (bookingsByHour[hour] ?? 0) + 1;
        profitByHour[hour] = (profitByHour[hour] ?? 0) + (booking.total ?? 0);
      }
    }

    // Create data points for the chart
    List<HourlyData> hourlyBookingData = [];
    List<HourlyData> hourlyProfitData = [];

    bookingsByHour.forEach((hour, count) {
      hourlyBookingData.add(HourlyData(hour, count));
      hourlyProfitData.add(HourlyData(hour, profitByHour[hour]!.toInt()));
    });

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Today's Statistics (${DateFormat('EEEE, MMMM d').format(today)})",
            size: Dimensions.font16.sp,
          ),
          SizedBox(height: Dimensions.height10.h),
          Expanded(
            child: SfCartesianChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Hour of Day'),
                minimum: 0,
                maximum: 23,
                interval: 2,
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Count'),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                // Bookings series
                ColumnSeries<HourlyData, int>(
                  name: 'Bookings',
                  dataSource: hourlyBookingData,
                  xValueMapper: (HourlyData data, _) => data.hour,
                  yValueMapper: (HourlyData data, _) => data.value,
                  color: AppColor.primaryColor,
                  width: 0.5,
                  spacing: 0.2,
                ),
                // Profit series (using line chart for clarity)
                LineSeries<HourlyData, int>(
                  name: 'Profit (\$)',
                  dataSource: hourlyProfitData,
                  xValueMapper: (HourlyData data, _) => data.hour,
                  yValueMapper: (HourlyData data, _) => data.value,
                  color: Colors.green,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ],
            ),
          ),

          // Today's Bookings List
          SizedBox(height: Dimensions.height10.h),
          BigText(
            text: "Today's Bookings (${todayBookings.length})",
            size: Dimensions.font16.sp,
          ),
          Expanded(
            child: todayBookings.isEmpty
                ? Center(child: SmallText(text: "No bookings for today"))
                : ListView.builder(
              itemCount: todayBookings.length,
              itemBuilder: (context, index) {
                final booking = todayBookings[index];
                return Card(
                  margin: EdgeInsets.only(bottom: Dimensions.height10.h),
                  child: ListTile(
                    title: BigText(
                      text: booking.userName ?? "Unknown",
                      size: Dimensions.font16.sp,
                    ),
                    subtitle: SmallText(
                      text: "Time: ${booking.startTime ?? 'N/A'}, Amount: \$${booking.total ?? 0}",
                    ),
                    trailing: Container(
                      width: Dimensions.width15.w,
                      height: Dimensions.width15.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: booking.approve == 0
                            ? Colors.orange
                            : booking.approve == 1
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWeeklyView(BookingControllerImp bookingController) {
    // Get the start of the current week (Sunday)
    final DateTime now = DateTime.now();
    final DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Create a list of days in the current week
    List<DateTime> daysOfWeek = List.generate(
      7,
          (index) => startOfWeek.add(Duration(days: index)),
    );

    // Create maps to store bookings and profits by day of week
    Map<int, int> bookingsByDay = {};
    Map<int, double> profitsByDay = {};

    // Initialize the maps
    for (int i = 0; i < 7; i++) {
      bookingsByDay[i] = 0;
      profitsByDay[i] = 0;
    }

    // Filter bookings for the current week and count by day
    for (var booking in bookingController.allBookings) {
      if (booking.day != null) {
        try {
          DateTime bookingDate = DateTime.parse(booking.day!);
          if (bookingDate.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
              bookingDate.isBefore(endOfWeek.add(const Duration(days: 1)))) {

            // Calculate day of week (0 = Sunday, 6 = Saturday)
            int dayOfWeek = bookingDate.weekday % 7;

            // Update counts and profits
            bookingsByDay[dayOfWeek] = (bookingsByDay[dayOfWeek] ?? 0) + 1;
            profitsByDay[dayOfWeek] = (profitsByDay[dayOfWeek] ?? 0) + (booking.total ?? 0);
          }
        } catch (e) {
          // Skip invalid dates
          continue;
        }
      }
    }

    // Create data for charts
    List<WeeklyData> weeklyBookingData = [];
    List<WeeklyData> weeklyProfitData = [];

    final List<String> dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    for (int i = 0; i < 7; i++) {
      weeklyBookingData.add(WeeklyData(dayNames[i], bookingsByDay[i] ?? 0));
      weeklyProfitData.add(WeeklyData(dayNames[i], (profitsByDay[i] ?? 0).toInt()));
    }

    // Calculate total for the week
    int totalWeeklyBookings = bookingsByDay.values.fold(0, (prev, count) => prev + count);
    double totalWeeklyProfit = profitsByDay.values.fold(0, (prev, amount) => prev + amount);

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: "Weekly Statistics",
                size: Dimensions.font16.sp,
              ),
              SmallText(
                text: "${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d').format(endOfWeek)}",
                color: AppColor.grey,
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10.h),

          // Weekly summary cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Week's Bookings",
                  totalWeeklyBookings.toString(),
                  AppColor.primaryColor,
                  Icons.calendar_view_week,
                ),
              ),
              SizedBox(width: Dimensions.width10.w),
              Expanded(
                child: _buildStatCard(
                  "Week's Profit",
                  "${totalWeeklyProfit.toStringAsFixed(2)} \$",
                  const Color(0xFF50C878),
                  Icons.monetization_on,
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.height15.h),
          Expanded(
            child: SfCartesianChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: CategoryAxis(),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                // Bookings column series
                ColumnSeries<WeeklyData, String>(
                  name: 'Bookings',
                  dataSource: weeklyBookingData,
                  xValueMapper: (WeeklyData data, _) => data.day,
                  yValueMapper: (WeeklyData data, _) => data.value,
                  color: AppColor.primaryColor,
                ),
                // Profit line series
                LineSeries<WeeklyData, String>(
                  name: 'Profit (\$)',
                  dataSource: weeklyProfitData,
                  xValueMapper: (WeeklyData data, _) => data.day,
                  yValueMapper: (WeeklyData data, _) => data.value,
                  color: Colors.green,
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ],
            ),
          ),

          // Daily breakdown in current week
          SizedBox(height: Dimensions.height10.h),
          BigText(
            text: "Daily Breakdown",
            size: Dimensions.font16.sp,
          ),
          SizedBox(height: Dimensions.height15.h),
          Expanded(
            child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                String dayName = dayNames[index];
                String formattedDate = DateFormat('MMM d').format(daysOfWeek[index]);
                int bookingCount = bookingsByDay[index] ?? 0;
                double profit = profitsByDay[index] ?? 0;

                return Card(
                  margin: EdgeInsets.only(bottom: Dimensions.height15.h),
                  child: ListTile(
                    title: BigText(
                      text: "$dayName ($formattedDate)",
                      size: Dimensions.font16.sp,
                    ),
                    subtitle: SmallText(
                      text: "Bookings: $bookingCount, Profit: \$${profit.toStringAsFixed(2)}",
                    ),
                    trailing: Icon(
                      Icons.trending_up,
                      color: bookingCount > 0 ? Colors.green : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMonthlyView(BookingControllerImp bookingController) {
    // Get the current month data
    final DateTime now = DateTime.now();
    final int currentMonth = now.month;
    final int currentYear = now.year;

    // Get days in current month
    final int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    // Create map to store bookings and profits by day of month
    Map<int, int> bookingsByDay = {};
    Map<int, double> profitsByDay = {};

    // Initialize with zeros
    for (int i = 1; i <= daysInMonth; i++) {
      bookingsByDay[i] = 0;
      profitsByDay[i] = 0;
    }

    // Filter bookings for current month and count by day
    for (var booking in bookingController.allBookings) {
      if (booking.day != null) {
        try {
          DateTime bookingDate = DateTime.parse(booking.day!);

          if (bookingDate.month == currentMonth && bookingDate.year == currentYear) {
            int dayOfMonth = bookingDate.day;

            bookingsByDay[dayOfMonth] = (bookingsByDay[dayOfMonth] ?? 0) + 1;
            profitsByDay[dayOfMonth] = (profitsByDay[dayOfMonth] ?? 0) + (booking.total ?? 0);
          }
        } catch (e) {
          // Skip invalid dates
          continue;
        }
      }
    }

    // Create data for charts
    List<MonthlyData> monthlyBookingData = [];
    List<MonthlyData> monthlyProfitData = [];

    for (int i = 1; i <= daysInMonth; i++) {
      monthlyBookingData.add(MonthlyData(i, bookingsByDay[i] ?? 0));
      monthlyProfitData.add(MonthlyData(i, (profitsByDay[i] ?? 0).toInt()));
    }

    // Calculate monthly totals
    int totalMonthlyBookings = bookingsByDay.values.fold(0, (prev, count) => prev + count);
    double totalMonthlyProfit = profitsByDay.values.fold(0, (prev, amount) => prev + amount);

    // Calculate weekly totals within the month
    Map<int, int> bookingsByWeek = {};
    Map<int, double> profitsByWeek = {};

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(currentYear, currentMonth, i);
      int weekOfMonth = ((i - 1) ~/ 7) + 1; // Calculate week number (1-indexed)

      bookingsByWeek[weekOfMonth] = (bookingsByWeek[weekOfMonth] ?? 0) + (bookingsByDay[i] ?? 0);
      profitsByWeek[weekOfMonth] = (profitsByWeek[weekOfMonth] ?? 0) + (profitsByDay[i] ?? 0);
    }

    return Padding(
      padding: EdgeInsets.all(Dimensions.height10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BigText(
                text: "Monthly Statistics",
                size: Dimensions.font16.sp,
              ),
              SmallText(
                text: DateFormat('MMMM yyyy').format(now),
                color: AppColor.grey,
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10.h),

          // Monthly summary cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Month's Bookings",
                  totalMonthlyBookings.toString(),
                  const Color(0xFF9370DB),
                  Icons.calendar_month,
                ),
              ),
              SizedBox(width: Dimensions.width10.w),
              Expanded(
                child: _buildStatCard(
                  "Month's Profit",
                  "${totalMonthlyProfit.toStringAsFixed(2)} \$",
                  const Color(0xFF50C878),
                  Icons.monetization_on,
                ),
              ),
            ],
          ),

          SizedBox(height: Dimensions.height15.h),
          BigText(
            text: "Daily Distribution",
            size: Dimensions.font16.sp,
          ),
          Expanded(
            child: SfCartesianChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              primaryXAxis: NumericAxis(
                title: AxisTitle(text: 'Day of Month'),
                minimum: 1,
                maximum: daysInMonth.toDouble(),
                interval: 5,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                // Bookings column series
                ColumnSeries<MonthlyData, int>(
                  name: 'Bookings',
                  dataSource: monthlyBookingData,
                  xValueMapper: (MonthlyData data, _) => data.day,
                  yValueMapper: (MonthlyData data, _) => data.value,
                  color: const Color(0xFF9370DB),
                  width: 0.3,
                ),
                // Profit line series
                LineSeries<MonthlyData, int>(
                  name: 'Profit (\$)',
                  dataSource: monthlyProfitData,
                  xValueMapper: (MonthlyData data, _) => data.day,
                  yValueMapper: (MonthlyData data, _) => data.value,
                  color: Colors.green,
                ),
              ],
            ),
          ),

          // Weekly breakdown within the month
          SizedBox(height: Dimensions.height10.h),
          BigText(
            text: "Weekly Breakdown",
            size: Dimensions.font16.sp,
          ),
          SizedBox(height: Dimensions.height15.h),
          Expanded(
            child: ListView.builder(
              itemCount: (daysInMonth / 7).ceil(),
              itemBuilder: (context, index) {
                int weekNumber = index + 1;

                // Calculate week start and end dates
                int startDay = (index * 7) + 1;
                int endDay = ((index + 1) * 7);
                if (endDay > daysInMonth) endDay = daysInMonth;

                DateTime startDate = DateTime(currentYear, currentMonth, startDay);
                DateTime endDate = DateTime(currentYear, currentMonth, endDay);

                String dateRange = "${DateFormat('MMM d').format(startDate)} - ${DateFormat('MMM d').format(endDate)}";

                int bookingCount = bookingsByWeek[weekNumber] ?? 0;
                double profit = profitsByWeek[weekNumber] ?? 0;

                return Card(
                  margin: EdgeInsets.only(bottom: Dimensions.height15.h),
                  child: ListTile(
                    title: BigText(
                      text: "Week $weekNumber ($dateRange)",
                      size: Dimensions.font16.sp,
                    ),
                    subtitle: SmallText(
                      text: "Bookings: $bookingCount, Profit: \$${profit.toStringAsFixed(2)}",
                    ),
                    trailing: Icon(
                      Icons.bar_chart,
                      color: bookingCount > 0 ? Colors.purple : Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to extract hour from time string like "3:00 PM"
  int _extractHourFromTimeString(String timeString) {
    try {
      // Handle various time formats
      if (timeString.contains("AM") || timeString.contains("PM")) {
        // Format: "3:00 PM"
        List<String> parts = timeString.split(':');
        int hour = int.parse(parts[0]);
        bool isPM = timeString.contains("PM");

        if (isPM && hour < 12) hour += 12;
        if (!isPM && hour == 12) hour = 0;

        return hour;
      } else if (timeString.contains(":")) {
        // Format: "15:00"
        return int.parse(timeString.split(':')[0]);
      } else {
        // Default to noon if format is unrecognized
        return 12;
      }
    } catch (e) {
      // Return noon as a fallback
      return 12;
    }
  }
}

// Data classes for the charts
class HourlyData {
  final int hour;
  final int value;

  HourlyData(this.hour, this.value);
}

class WeeklyData {
  final String day;
  final int value;

  WeeklyData(this.day, this.value);
}

class MonthlyData {
  final int day;
  final int value;

  MonthlyData(this.day, this.value);
}