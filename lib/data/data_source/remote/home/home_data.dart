import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  postData(String category, String country, String city) async {
    var response = await crud.postData(AppLink.home, {
      "category": category,
      "country": country,
      "city": city,
    });
    return response.fold((l) => l, (r) => r);
  }
}
