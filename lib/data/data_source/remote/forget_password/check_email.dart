import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class CheckEmailData {
  Crud crud;

  CheckEmailData(this.crud);

  postData(String email) async {
    var response = await crud.postData(AppLink.checkEmail, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
