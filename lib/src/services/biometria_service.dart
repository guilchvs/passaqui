// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/services/auth_service.dart'; // Import your AuthService
//
// class BiometriaService {
//   final String baseUrl =
//       'http://passcash-api-hml.us-east-1.elasticbeanstalk.com/api'; // Replace with your API base URL
//   final AuthService _authService;
//
//   BiometriaService(this._authService);
//
//   Future<void> fetchBiometriaData() async {
//     try {
//       final token = await _authService.getToken();
//       if (token == null) {
//         throw Exception('Token not available'); // Handle token absence as needed
//       }
//
//       final url = Uri.parse('$baseUrl/ApiMaster/retornoBiometria'); // Replace with your API endpoint
//       final response = await http.get(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token', // Include Bearer token in headers
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print('Biometria Data: $responseData');
//       } else {
//         throw Exception('Failed to load biometria data');
//       }
//     } catch (e) {
//       print('Error fetching biometria data: $e');
//       throw e; // Propagate the error for handling in UI or elsewhere
//     }
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:passaqui/src/services/auth_service.dart'; // Import your AuthService
//
// class BiometriaService {
//   final String baseUrl =
//       'http://passcash-api-hml.us-east-1.elasticbeanstalk.com'; // Replace with your API base URL
//   final AuthService _authService;
//
//   BiometriaService(this._authService);
//
//   Future<int> fetchBiometriaData() async {
//     try {
//       final token = await _authService.getToken();
//       if (token == null) {
//         throw Exception('Token not available'); // Handle token absence as needed
//       }
//
//       final url = Uri.parse('$baseUrl/api/ApiMaster/retornoBiometria'); // Replace with your API endpoint
//       final response = await http.get(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $token', // Include Bearer token in headers
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = int.parse(response.body);
//         return responseData;
//       } else {
//         throw Exception('Failed to load biometria data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching biometria data: $e');
//       throw e; // Propagate the error for handling in UI or elsewhere
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:passaqui/src/services/auth_service.dart';

import '../core/app_config.dart';

class BiometriaService {
  final AuthService _authService;

  BiometriaService(this._authService);

  Future<int> fetchBiometriaData() async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        throw Exception('Token not available'); // Handle token absence as needed
      }

      final url = Uri.parse('${AppConfig.api.apiMaster}/retornoBiometria'); // Replace with your API endpoint
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Include Bearer token in headers
        },
      );

      if (response.statusCode == 200) {
        final responseData = int.parse(response.body);
        return responseData;
      } else {
        return 100;
      }
    } catch (e) {
      print('Error fetching biometria data: $e');
      throw e; // Propagate the error for handling in UI or elsewhere
    }
  }
}

