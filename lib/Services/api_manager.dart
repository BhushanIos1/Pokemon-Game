import 'dart:async';
import 'dart:convert';
import 'package:pokemon_game/Services/web_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:pokemon_game/font_extension.dart';
import 'package:pokemon_game/Extension/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ApiManager {
  // Singleton pattern to ensure a single instance of ApiManager
  static final ApiManager _instance = ApiManager._internal();
  factory ApiManager() => _instance;
  ApiManager._internal();

  String? _token;

  void setToken(String token) {
    _token = token;
  }

  BuildContext? _loaderContext;

  // Helper method to add authorization header
  Map<String, String> _getHeaders() {
    final headers = Map<String, String>.from(ApiUrl.headers);
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // Helper method to make GET requests
  Future<dynamic> get(BuildContext context, String url) async {
    print('GET Request: $url');
    showLoader(context);
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      // Do not print response body
      hideLoader(); // Hide loader
      return _handleResponse(context, response);
    } on TimeoutException {
      hideLoader();
      showSnackBar(context, 'Request timed out', isError: true);
      // Do not throw, just return null or an empty map/list as appropriate
      return null;
    } catch (e) {
      hideLoader();
      final errorMessage = _handleError(e);
      showSnackBar(context, errorMessage, isError: true);
      // Do not throw, just return null or an empty map/list as appropriate
      return null;
    }
  }

  // Handle the API response
  dynamic _handleResponse(BuildContext context, http.Response response) {
    if (response.body.isEmpty) {
      showSnackBar(context, 'Empty response from server', isError: true);
      return null;
    }
    try {
      final responseBody = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200: // Success
          // Do not show success snackbar
          return jsonDecode(response.body);
        case 201: // Created
          // Do not show success snackbar
          return jsonDecode(response.body);
        case 400: // Bad Request
          showSnackBar(
            context,
            responseBody['message'] ?? 'Bad Request',
            isError: true,
          );
          return null;
        case 401: // Unauthorized
          showSnackBar(
            context,
            responseBody['message'] ?? 'Unauthorized',
            isError: true,
          );
          return null;
        case 403: // Forbidden
          showSnackBar(
            context,
            responseBody['message'] ?? 'Forbidden',
            isError: true,
          );
          return null;
        case 404: // Not Found
          showSnackBar(
            context,
            responseBody['message'] ?? 'Not Found',
            isError: true,
          );
          return null;
        case 500: // Internal Server Error
          showSnackBar(
            context,
            responseBody['message'] ?? 'Internal Server Error',
            isError: true,
          );
          return null;
        default:
          showSnackBar(
            context,
            responseBody['message'] ?? 'Something went wrong',
            isError: true,
          );
          return null;
      }
    } catch (e) {
      showSnackBar(
        context,
        'Invalid data format: ${e.toString()}',
        isError: true,
      );
      return null;
    }
  }

  // Handle errors
  String _handleError(dynamic error) {
    if (error is http.ClientException) {
      return 'Network error: ${error.message}';
    } else if (error is FormatException) {
      return 'Invalid data format: ${error.message}';
    } else if (error is TimeoutException) {
      return 'Request timed out';
    } else {
      return '$error';
    }
  }

  // Show Loader for messages
  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        _loaderContext = dialogContext;
        return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: Colors.yellowAccent,
            size: 60,
          ),
        );
      },
    );
  }

  void hideLoader() {
    if (_loaderContext != null) {
      Navigator.pop(_loaderContext!);
      _loaderContext = null;
    }
  }

  // Show SnackBar for messages
  void showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
    bool isInfo = false,
  }) {
    Color backgroundColor;

    if (isError) {
      backgroundColor = Colors.red;
    } else if (isInfo) {
      backgroundColor = Colors.lightBlueAccent;
    } else {
      backgroundColor = Colors.green;
    }

    awesomeTopSnackbar(
      context,
      message,
      backgroundColor: backgroundColor,
      textStyle: const TextStyle(
        color: AppColors.whiteColor,
      ).medium(fontSize: 16),
      //icon: const Icon(Icons.close, color: Colors.white)
    );
  }
}
