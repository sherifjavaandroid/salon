import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easycut_business/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map<String, dynamic>>> postData(
      String linkUrl, Map<String, dynamic> data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: data,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          Logger().i(responseBody);
          return Right(responseBody);
        } else {
          Logger().e(
              'Server Error: ${response.statusCode}'); // Improved error logging
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        Logger().w('No internet connection.'); // Log warning for offline status
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      Logger().e('Exception: $e'); // Improved exception logging
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> getData(
      String url) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody); // Wrap response in Right
        } else {
          Logger().e(
              'Server Error: ${response.statusCode}'); // Improved error logging
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        Logger().w('No internet connection.'); // Log warning for offline status
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      Logger().e('Exception: $e'); // Improved exception logging
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> postDataWithFile(
    String linkUrl,
    Map<String, dynamic> data,
    File file,
  ) async {
    try {
      // Check for internet connection
      if (await checkInternet()) {
        // Create a new MultipartRequest
        var request = http.MultipartRequest(
          "POST",
          Uri.parse(linkUrl),
        );

        // Get the file's length and prepare it as a stream
        var length = await file.length();
        var stream = http.ByteStream(file.openRead());

        // Create a MultipartFile and add it to the request
        var multipartFile = http.MultipartFile(
          "file", // The field name for the file in the backend
          stream,
          length,
          filename: file.path.split('/').last, // The file name
        );

        request.files.add(multipartFile);

        // Add additional data to the request fields
        data.forEach((key, value) {
          request.fields[key] = value;
        });

        // Send the request and wait for the response
        var myRequest = await request.send();
        var response = await http.Response.fromStream(myRequest);

        // Check for successful response
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          return Right(responseBody); // Success case
        } else {
          Logger().e(
              'Server Error: ${response.statusCode}'); // Improved error logging
          return const Left(StatusRequest.serverFailure); // Server failure case
        }
      } else {
        return const Left(
            StatusRequest.offlineFailure); // No internet connection
      }
    } catch (e) {
      Logger().e('Exception: $e'); // Improved exception logging
      return const Left(
          StatusRequest.serverException); // Exception handling case
    }
  }
}
