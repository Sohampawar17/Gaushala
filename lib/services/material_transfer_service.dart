import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaushala/models/material_master.dart';
import 'package:gaushala/models/material_transfer.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class StockService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<MaterialTransferMaster?> masters() async {
    try {
      final url =
          '$baseurl/api/method/goshala_sanpra.custom_pyfile.login_master.materialMasters';
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200) {
        return MaterialTransferMaster.fromJson(response.data["data"]);
      } else {
        _showToast("Unable to load dashboard data");
      }
    } catch (e) {
      print(e);
      _handleDioError(e, context: "purchase_master");
    }
    return null;
  }

  Future<bool> delete(StockList customer) async {
    try {
      final url = '$baseurl/api/resource/Stock Entry/${customer.name}';
      final response = await _dio.put(
        url,
        data: {'docstatus': 2},
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        _showToast("Unable to delete data");
      }
    } catch (e) {
      _handleDioError(e, context: "delete animal");
    }
    return false;
  }

  Future<bool> create(MaterialTransfer customer) async {
    try {
      print(customer.toJson());
      final url = '$baseurl/api/resource/Stock Entry';
      final response = await _dio.post(
        url,
        data: customer.toJson(),
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        return true;
      } else {
        _showToast("Unable to post data");
      }
    } catch (e) {
      _handleDioError(e, context: "create collection");
    }
    return false;
  }

  void _handleDioError(dynamic error, {String? context}) {
    String message = "Unexpected error occurred";

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          message = "Request was cancelled.";
          break;
        case DioExceptionType.connectionTimeout:
          message = "Connection timeout. Please try again later.";
          break;
        case DioExceptionType.sendTimeout:
          message = "Send timeout. Please try again.";
          break;
        case DioExceptionType.receiveTimeout:
          message = "Receive timeout. Please check your internet.";
          break;
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final responseMessage = error.response?.data?["message"] ??
              error.response?.data ??
              "Received invalid status code: $statusCode";
          print(error.response?.data);

          message = "Error $statusCode: $responseMessage";
          break;
        case DioExceptionType.badCertificate:
          message = "Bad certificate. Connection refused.";
          break;
        case DioExceptionType.connectionError:
          message = "Network error. Please check your connection.";
          break;
        case DioExceptionType.unknown:
          final err = error.error;
          if (err is SocketException) {
            message = "No internet connection.";
          } else {
            message = "Unknown error: ${err.toString()}";
          }
          break;
      }
    } else if (error is SocketException) {
      message = "No internet connection.";
    } else if (error is FormatException) {
      message = "Data format error.";
    } else if (error is Exception) {
      message = error.toString();
    }

    _showToast(message, isError: true);
    _logger.e('[${context ?? "ErrorHandler"}] $message');
  }

  /// Shows a consistent toast message for success or error
  void _showToast(String msg, {bool isError = false, bool success = false}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      textColor: const Color(0xFFFFFFFF),
      backgroundColor: isError
          ? const Color(0xFFBA1A1A)
          : success
              ? const Color.fromARGB(255, 26, 186, 29)
              : const Color(0xFF666666),
    );
  }
}
