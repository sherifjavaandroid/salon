import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easycut_business/core/class/crud.dart';
import 'package:easycut_business/linkapi.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ServicesData {
  Crud crud;

  ServicesData(this.crud);

  // Method to retrieve service data
  getData(String salonId) async {
    var response = await crud.postData(AppLink.servicesView, {
      "salonid": salonId,
    });
    return response.fold((l) => l, (r) => r);
  }

  // Method to add new service data
  Future<dynamic> postData(
    String salonId,
    String name,
    String price,
    String time,
    File image,
  ) async {
    try {
      // Prepare the data to be sent in the request
      var formData = {
        "salonid": salonId,
        "name": name,
        "price": price,
        "time": time,
      };

      File imageFile =
          image; // Ensure this is the image file you want to upload

      var response = await crud.postDataWithFile(
        AppLink.servicesAdd, // Add API endpoint
        formData, // Pass a Map<String, dynamic> containing the fields
        imageFile, // Pass the image file separately
      );

      // Return the response, handling the fold function
      return response.fold(
        (l) => l, // Handle error case
        (r) => r, // Handle success case
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading data: $e');
      }
      return null;
    }
  }

  Future<dynamic> editData(
      String id, String name, String price, String time, File image) async {
    var formData = {
      "id": id,
      "name": name,
      "price": price,
      "time": time,
    };

    var response = await crud.postDataWithFile(
      AppLink.servicesEdit, // Update this endpoint to your edit endpoint
      formData,
      image,
    );

    return response.fold(
      (l) => l, // Handle error
      (r) => r, // Handle success
    );
  }

  Future<dynamic> deleteData(String id, String oldImage) async {
    try {
      var formData = {
        "id": id,
        "oldimage": oldImage,
      };

      var response = await crud.postData(
        AppLink.servicesdelete, // Your API endpoint for deleting products
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
