import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class CommentData {
  Crud crud;

  CommentData(this.crud);

  postData(String salonId) async {
    var response = await crud.postData(AppLink.commentView, {
      "salonid": salonId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
