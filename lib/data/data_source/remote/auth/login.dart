import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postData(
    String email,
    String password,
  ) async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
  postDataWithPhone(String phone, String countryCode, String password) async {
    var response = await crud.postData(AppLink.login, { // Add this endpoint to AppLink
      "phone": phone,
      "country_code": countryCode,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
  postDataWithEmail(String email, String password) async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
