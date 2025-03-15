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

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return {
        "success": true,
        "message": responseBody["message"],
        "username": responseBody["username"],
        "id": responseBody["id"],
      };
    } else {
      return {
        "success": false,
        "message":
            jsonDecode(response.body)["message"] ?? "Something went wrong"
      };
    }
  }

// Taker Login
  static Future<Map<String, dynamic>> takerLogin(
      Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse("$baseUrl/taker/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return {
        "success": true,
        "message": responseBody["message"],
        "username": responseBody["username"],
        "id": responseBody["id"],
      };
    } else {
      return {
        "success": false,
        "message":
            jsonDecode(response.body)["message"] ?? "Something went wrong"
      };
    }
  }

  // Get All Parking
  static Future<Map<String, dynamic>> getAllParking() async {
    final response = await http.get(
      Uri.parse("$baseUrl/parking/"), // Replace with your actual endpoint
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // Decoding the response body into a Map
      final responseBody = jsonDecode(response.body);

      // Extracting message, success, and data fields
      return {
        "success": responseBody["success"],
        "message": responseBody["message"],
        "data": responseBody["data"], // Assuming data contains the parking list
      };
    } else {
      // Handling non-200 responses
      throw Exception("Failed to fetch parking data: ${response.statusCode}");
    }
  }

  // Get Taker Profile
  static Future<Map<String, dynamic>> getProfile(String id) async {
    final response = await http.get(
      Uri.parse(
          "$baseUrl/parking/profile?id=$id"), // Endpoint with request parameter
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // Decoding the response body into a Map
      final responseBody = jsonDecode(response.body);

      // Extracting specific fields from the data
      final data = responseBody["data"];
      return {
        "success": responseBody["success"],
        "message": responseBody["message"],
        "data": {
          "name": data["name"], // Replace 'field1' with the actual field name
          "email": data["email"], // Replace 'field2' with the actual field name
        },
      };
    } else {
      // Handling non-200 responses
      throw Exception("Failed to fetch profile: ${response.statusCode}");
    }
  }

  // Get Provider Profile
  static Future<Map<String, dynamic>> getProviderProfile(String id) async {
    final response = await http.get(
      Uri.parse(
          "$baseUrl/parking/providerProfile?id=$id"), // Endpoint with request parameter
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      // Decoding the response body into a Map
      final responseBody = jsonDecode(response.body);

      // Extracting specific fields from the data
      final data = responseBody["data"];
      return {
        "success": responseBody["success"],
        "message": responseBody["message"],
        "data": {
          "name": data["name"], // Replace 'field1' with the actual field name
          "email": data["email"], // Replace 'field2' with the actual field name
        },
      };
    } else {
      // Handling non-200 responses
      throw Exception("Failed to fetch profile: ${response.statusCode}");
    }
  }

  // Booking Parking Spot (Book Now)
  static Future<Map<String, dynamic>> bookNow(Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse(
          "$baseUrl/taker/book"), // Replace with your actual booking endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Successful response handling
      final responseBody = jsonDecode(response.body);
      return {
        "success": responseBody["success"],
        "message": responseBody["message"],
        "data": responseBody["data"], // Booking details returned from backend
      };
    } else {
      // Error handling for non-201 responses
      final responseBody = jsonDecode(response.body);
      return {
        "success": responseBody["success"] ?? false,
        "message": responseBody["message"] ?? "Failed to book parking",
        "data": null, // No data on error
      };
    }
  }

  // Add Parking
  static Future<Map<String, dynamic>> addParking(
      Map<String, dynamic> parkingSpot, int providerId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/parking/provider/$providerId/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(parkingSpot),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return {
        "success": true,
        "message": responseBody["message"],
        "data": responseBody["data"], // Adjust this based on your API response
        "id": responseBody["id"],
      };
    } else {
      return {
        "success": false,
        "message":
            jsonDecode(response.body)["message"] ?? "Something went wrong",
      };
    }
  }

  // Get Parking by ID
  static Future<Map<String, dynamic>> getParkingById(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/parking/$id"), // Replace with your actual endpoint
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      // Decoding the response body into a Map
      final responseBody = jsonDecode(response.body);

      // Extracting message, success, and data fields
      return {
        "success": responseBody["success"],
        "message": responseBody["message"],
        "data":
            responseBody["data"], // Assuming data contains parking spot details
      };
    } else {
      // Handling non-200 responses
      throw Exception(
          "Failed to fetch parking data for ID $id: ${response.statusCode}");
    }
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
        "id": responseBody["id"],
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
