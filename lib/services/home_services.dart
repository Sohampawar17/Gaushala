import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaushala/models/dashboard.dart';
import 'package:gaushala/screens/company/company_viewmodel.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class HomeServices {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<Dashboard?> dashboard() async {
    try {
      final url =
          '$baseurl/api/method/goshala_sanpra.custom_pyfile.login_master.get_dashboard';
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        return Dashboard.fromJson(response.data["data"]);
      } else {
        _showToast("Unable to load dashboard data");
      }
    } catch (e) {
      print(e);
      _handleDioError(e, context: "dashboard");
    }
    return null;
  }

  Future<Company?> company() async {
    try {
      final url =
          '$baseurl/api/method/goshala_sanpra.custom_pyfile.login_master.company';
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        return Company.fromJson(response.data["data"]);
      } else {
        _showToast("Unable to load dashboard data");
      }
    } catch (e) {
      _handleDioError(e, context: "dashboard");
    }
    return null;
  }

  /// Handles DioException and logs properly
  void _handleDioError(dynamic error, {String? context}) {
    String message = "Unexpected error";

    if (error is DioException) {
      final responseMessage = error.response?.data?["message"] ?? error.message;
      message = "Error: $responseMessage";
    } else if (error is Exception) {
      message = error.toString();
    }

    _showToast(message, isError: true);
    _logger.e('[$context] $message');
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
