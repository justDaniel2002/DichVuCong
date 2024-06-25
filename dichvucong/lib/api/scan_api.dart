import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dichvucong/models/data_model.dart';
import 'dart:convert';

class ScanApi {
  static Future<DataModel?> uploadImage(String path) async {
    var url = Uri.parse('https://api.fpt.ai/vision/idr/vnm');
    var apiKey = 'yKDqKKycqLuiSzoFoNCxR6GdO5N9lH4w';
    var file = File(path); // Replace with actual path to your image file

    // Create a multipart request
    var request = http.MultipartRequest('POST', url);

    // Add headers
    request.headers['api-key'] = apiKey;

    // Add file to multipart form data
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    // Send request
    var response = await request.send();

    // Read response stream into a string
    var responseString = await response.stream.bytesToString();

    // Print response body
    print('Response body:');
    print(responseString);

    // Check the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      Map<String, dynamic> jsonMap = jsonDecode(responseString);
      List<dynamic> dataList = jsonMap['data'];
      Map<String, dynamic> dataItem = dataList.first;

      // Create a DataModel instance using the fromJson factory constructor
      return DataModel.fromJson(dataItem);
    } else {
      print('Image upload failed with status ${response.statusCode}');
      return null;
    }
  }
}
