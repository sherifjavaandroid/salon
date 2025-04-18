import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class ResetPasswordData {
  Crud crud;

  ResetPasswordData(this.crud);

  postData(String email, String password) async {
    var response = await crud.postData(AppLink.resetPassword, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }
}
