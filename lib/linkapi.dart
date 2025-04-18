class AppLink {
  static const String server = "https://easycuteg.com";
  static const String imageServices = "https://easycuteg.com/upload/services/";
  static const String imageSalons = "https://easycuteg.com/upload/salons/";
  static const String imageUsers = "https://easycuteg.com/upload/users/";
  static const String imageProducts = "https://easycuteg.com/upload/products/";
// ================================= Auth ==========================
  static const String login = "$server/salons/auth/login.php";
  static const String checkEmail = "$server/salons/auth/checkemail.php";
  static const String resetPassword = "$server/salons/auth/resetpassword.php";
// ================================= Home ====================
  static const String home = "$server/users/home/home.php";
  static const String salonInfo = "$server/salons/profile/show.php";
  static const String salonInfoEdit = "$server/salons/profile/edit.php";
  static const String commentView = "$server/comments/view.php";
  static const String appointmentView = "$server/appointments/show.php";
  static const String appointmentAdd = "$server/appointments/add.php";
  static const String servicesView = "$server/salons/services/view.php";
  static const String servicesAdd = "$server/salons/services/add.php";
  static const String servicesEdit = "$server/salons/services/edit.php";
  static const String servicesdelete = "$server/salons/services/delete.php";

  static const String productsView = "$server/salons/products/view.php";
  static const String productsAdd = "$server/salons/products/add.php";
  static const String productsEdit = "$server/salons/products/edit.php";
  static const String productsdelete = "$server/salons/products/delete.php";
  static const String customersView = "$server/salons/customers/view.php";
  static const String bookingsView = "$server/salons/booking/view.php";
  static const String bookingsShow = "$server/salons/booking/show.php";
  static const String bookingsEdit = "$server/salons/booking/edit.php";
  static const String customeradd = "$server/booking/add_custom.php";
}
