import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  final Logger _logger = Logger();
  final Dio _dio = Dio();

  Future<bool> login(String url, String username, String password) async {
    try {
      final response = await _dio.post(
        '$url/api/method/goshala_sanpra.custom_pyfile.login_master.login',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {
          'usr': username,
          'pwd': password,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        await _storeLoginDetails(url, response.data);
        _showToast('Logged in successfully', success: true);
        return true;
      }

      _showToast('Login failed. Please try again.');
      return false;
    } on DioException catch (e) {
      final msg = _getErrorMessage(e);
      _logger.e('DioException: ${e.response?.data}');
      _showToast('Error: $msg');
      return false;
    } catch (e, stacktrace) {
      _logger.e('Unhandled exception: $e\n$stacktrace');
      _showToast('Unexpected error occurred. Please contact support.');
      return false;
    }
  }

  Future<void> _storeLoginDetails(String url, dynamic data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('url', url);
    prefs.setString('api_secret', data["key_details"]["api_secret"].toString());
    prefs.setString('api_key', data["key_details"]["api_key"].toString());
    prefs.setString('user', data["user"].toString());

    _logger.i('Login data stored:\nAPI Key: ${prefs.getString('api_key')}');
  }

  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your network.';
      case DioExceptionType.receiveTimeout:
        return 'Response timed out. Try again later.';
      case DioExceptionType.badResponse:
        return e.response?.data["message"]?.toString() ??
            'Invalid response from server.';
      case DioExceptionType.unknown:
        return 'No Internet connection or unexpected error.';
      default:
        return 'Unknown error occurred.';
    }
  }

  void _showToast(String message, {bool success = false}) {
    Fluttertoast.showToast(
      gravity: ToastGravity.BOTTOM,
      msg: message,
      textColor: Colors.white,
      backgroundColor: success
          ? const Color(0xFF1ABA52) // Green
          : const Color(0xFFBA1A1A), // Red
    );
  }
}
