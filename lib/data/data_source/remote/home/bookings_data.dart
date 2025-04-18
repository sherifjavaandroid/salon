import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class BookingsData {
  Crud crud;

  BookingsData(this.crud);

  viewAll(String salonId) async {
    var response = await crud.postData(AppLink.bookingsView, {
      "salonid": salonId,
    });
    return response.fold((l) => l, (r) => r);
  }

  showServices(String bookingId) async {
    var response = await crud.postData(AppLink.bookingsShow, {
      "bookingid": bookingId,
    });
    return response.fold((l) => l, (r) => r);
  }

  editData(
    String id,
    String approve,
  ) async {
    var response = await crud.postData(AppLink.bookingsEdit, {
      "id": id,
      "approve": approve,
    });
    return response.fold((l) => l, (r) => r);
  }
}
