import 'dart:io';

import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class ProfileData {
  Crud crud;

  ProfileData(this.crud);

  getData(String id) async {
    var response = await crud.postData(AppLink.salonInfo, {
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  postData(
    String id,
    String chairs,
    String imageold,
    File image,
  ) async {
    var response = await crud.postDataWithFile(
      AppLink.salonInfoEdit,
      {
        "id": id,
        "chairs": chairs,
        "imageold": imageold,
      },
      image,
    );
    return response.fold((l) => l, (r) => r);
  }
}
