import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class RestConstant {
  static String Baseurl = 'http://api.audiokumbh.in/mobile/';
  static String endpoint = 'homepage/get';
}

class ResponseService {
  static bool connnect = false;
  static String? responceBody;
  static Map<String, dynamic>? Bodymap;

  static Future<String?> postRestUrl(
      String? endpoint, Map<String, dynamic>? Bodymap) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      connnect = true;
    }
    if (!connnect) {
      return responceBody;
    }
    var headers = {
      'Content-Type': 'application/json',
      'x-auth-token':
          'U2FsdGVkX18HncEy8lhKLk8pIVKWYTPwcNC/FQhb+EphURd+k7F1SJFeL8V1jMomgnHTBkMw3oO3yqjXeNq3ORa/LDRnS7mA2HtkxuWLQghkGfXnypKL3QLkQMd/cT9HFd6LjWizDjBi1G7w7MDUNyG2kDOQr/6Z9uSyK2Zku8X8tKL/yBjw/vkCWPCYeKMXz5wZw+oNObR9pcuXHIv+p7PRlkIrbGiqtdtJQ7h6OQ3zRLHeFQDFVqwDdqUA9gv7'
    };

    Map<String,dynamic> bodyMap = { "useFor": "audiobook" };

    var url = Uri.parse('${RestConstant.Baseurl}${RestConstant.endpoint}');
    var response =
        await http.post(url, headers: headers, body: jsonEncode(bodyMap));
    print('Response status:${response.statusCode}');
    print('Response body:${response.body}');
    responceBody = response.body;
    try {
      switch (response.body) {
        case 200:

      }return response.body;
    }on Exception catch(e)
    {
      print("throwing new error${e}");
      throw Exception ("Error on server");
    }


  }
}
