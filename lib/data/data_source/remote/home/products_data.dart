import 'dart:io';

import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';

class ProductsData {
  Crud crud;

  ProductsData(this.crud);

  // Method to get product data based on salonId
  Future<dynamic> getData(String salonId) async {
    var response = await crud.getData(
      '${AppLink.productsView}?salonid=$salonId',
    );
    return response.fold((l) => l, (r) => r);
  }

  // Method to post product data including image
  Future<dynamic> postData(
    String salonId,
    String name,
    String price,
    String number,
    File image,
  ) async {
    try {
      // Prepare the form data
      var formData = {
        "salonid": salonId,
        "name": name,
        "price": price,
        "number": number,
      };

      // Pass the form data and image to postDataWithFile
      var response = await crud.postDataWithFile(
        AppLink.productsAdd, // Your API endpoint for adding products
        formData, // Fields to be sent
        image, // Image file to be uploaded
      );

      // Handle the response using fold
      return response.fold(
        (l) => l, // Handle error case
        (r) => r, // Handle success case
      );
    } catch (e) {
      print('Error uploading product data: $e');
      return null; // Handle errors
    }
  }

  // Method to edit product data
  Future<dynamic> editData(
    String id,
    String name,
    String price,
    String number,
    File image,
    var active,
  ) async {
    var formData = {
      "id": id,
      "name": name,
      "price": price,
      "number": number,
      "active": 1.toString(),
    };

    var response = await crud.postDataWithFile(
      AppLink.productsEdit, // Update this endpoint to your edit endpoint
      formData,
      image,
    );

    return response.fold(
      (l) => l, // Handle error
      (r) => r, // Handle success
    );
  }

  // Method to delete product data
  Future<dynamic> deleteData(String id, String oldImage) async {
    try {
      var formData = {
        "id": id,
        "oldimage": oldImage,
      };

      var response = await crud.postData(
        AppLink.productsdelete, // Your API endpoint for deleting products
        formData, // Fields to be sent
      );

      // Handle the response using fold
      return response.fold(
        (l) => l, // Handle error case
        (r) => r, // Handle success case
      );
    } catch (e) {
      print('Error deleting product data: $e');
      return null; // Handle errors
    }
  }
}
