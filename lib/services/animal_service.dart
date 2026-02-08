import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaushala/models/animals_model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class AnimalService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  Future<AnimalMasters?> masters() async {
    try {
      final url =
          '$baseurl/api/method/goshala_sanpra.custom_pyfile.login_master.get_animal_master';
      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        return AnimalMasters.fromJson(response.data["data"]);
      } else {
        _showToast("Unable to load dashboard data");
      }
    } catch (e) {
      _handleDioError(e, context: "dashboard");
    }
    return null;
  }

  Future<Animals?> get(String id) async {
    try {
      final url = '$baseurl/api/resource/Animals/$id';

      final response = await _dio.get(
        url,
        options: Options(headers: {'Authorization': await getToken()}),
      );

      if (response.statusCode == 200 && response.data["data"] != null) {
        return Animals.fromJson(response.data["data"]);
      } else {
        _showToast("Unable to load dashboard data");
      }
    } catch (e) {
      _handleDioError(e, context: "dashboard");
    }
    return null;
  }

  Future<bool> create(Animals customer) async {
    try {
      final url = '$baseurl/api/resource/Animals';
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
      _handleDioError(e, context: "create_animal");
    }
    return false;
  }

  Future<bool> update(Animals customer) async {
    try {
      final url = '$baseurl/api/resource/Animals/${customer.name}';
      final response = await _dio.put(
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
      _handleDioError(e, context: "create_animal");
    }
    return false;
  }

  Future<bool> delete(Animals customer) async {
    try {
      final url = '$baseurl/api/resource/Animals/${customer.name}';
      final response = await _dio.delete(
        url,
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

  Future<List<Animals>> fetchAnimals() async {
    try {
      final response = await _dio.get(
        '$baseurl/api/resource/Animals?fields=["name","animal_type","animal_id","gender","parent1","date_of_birth"]&limit=1000&order_by=creation desc',
        options: Options(headers: {'Authorization': await getToken()}),
      );

      return List<Animals>.from(
        response.data["data"].map((e) => Animals.fromJson(e)),
      );
    } catch (e) {
      _handleDioError(e, context: "create_animal");

      return [];
    }
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
