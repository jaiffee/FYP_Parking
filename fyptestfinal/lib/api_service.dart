import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8080"; // Update this

  // Provider Signup
  static Future<Map<String, dynamic>> providerSignup(
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/provider/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // Taker Signup
  static Future<Map<String, dynamic>> takerSignup(
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/taker/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // Provider Login
  static Future<Map<String, dynamic>> providerLogin(
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/provider/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // Taker Login
  static Future<Map<String, dynamic>> takerLogin(
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/taker/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // Handle Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Decoding the response body
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Return the complete response including success, message, and username
      return {
        "success": true,
        "message": responseBody["message"],
        "username":
            responseBody["username"], // Add the username to the response
      };
    } else {
      return {
        "success": false,
        "message":
            jsonDecode(response.body)["message"] ?? "Something went wrong"
      };
    }
  }
}
