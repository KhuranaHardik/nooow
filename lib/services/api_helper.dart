import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

class ApiHelper {
  static Future<Response> postEncodeCall(
      {required String path, required Map<String, dynamic> parameters}) async {
    Uri url = Uri.parse(path);
    final result = await post(url,
        headers: header(),
        // encoding: Encoding.getByName("utf-8"),
        body: json.encode(parameters));
    debugPrint(path);
    debugPrint("parameters => ${jsonEncode(parameters)}");
    debugPrint(result.statusCode.toString());
    debugPrint("api body ==> ${result.body} ");
    debugPrint(path);
    return result;
  }

  // api header
  static Map<String, String> header() => {
        // "Accept": "application/json",
        // "Content-Type": "application/json",
      };
}
