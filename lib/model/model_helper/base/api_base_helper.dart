import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../../../helper/end_points.dart';
import 'api_exceptions.dart';

class ApiBaseHelper {
  GetStorage box = GetStorage();

  Future<List<T>> get<T>(
    String url,
    T Function(Map<String, dynamic>) fromJson, {
    Map<String, String>? headers,
    int timeout = 10,
  }) async {
    String urlHandling = baseUrl() + url;

    if (kDebugMode) {
      print('Api GET, url: $urlHandling');
    }

    try {
      final response = await http
          .get(Uri.parse(urlHandling), headers: headers)
          .timeout(Duration(seconds: timeout));

      final jsonResponse = _returnResponse(response);
      final list = jsonResponse['lst'] as List<dynamic>;

      return list.map((item) => fromJson(item)).toList();
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      rethrow;
    }
  }

  Future<dynamic>   post(
    String url,
    Object body,
    Function(Map<String, dynamic> json) jsonFun, {
    headers,
    timeOut = 10,
  }) async {
    String urlHandling = baseUrl() + url;

    if (kDebugMode) {
      print('Api POST, url: ${baseUrl() + url}');
      print(json.encode(body));
    }

    var responseJson;
    try {
      final response = await http
          .post(
            Uri.parse(urlHandling),
            body: json.encode(body),
            headers: headers,
          )
          .timeout(Duration(seconds: timeOut));

      responseJson = _returnResponse(response);
      final jsonResponse = _returnResponse(response);
      if(jsonResponse['lst']==null){
        return responseJson;
      }else{
        final list = jsonResponse['lst'] as List<dynamic>;

        responseJson= list.map((item) => jsonFun(item)).toList();
        if(responseJson.isNotEmpty){
          return responseJson[0];
        }else{
          return "";
        }
      }

    } on TimeoutException catch (e) {
      throw 'TimeoutException: ${e.toString().tr}';
    } on SocketException catch (e) {{
      throw 'SocketException: ${e.toString().tr}';
    }

    // if (kDebugMode) print(json.encode(body));
    // var response = jsonFun(responseJson);
    // return response;

}
  }}

dynamic _returnResponse(http.Response response) {
  var responseJson = json.decode(response.body);
  print(responseJson);
  if (kDebugMode) {
    print(responseJson);
  }

  if (!responseJson["isSuccess"]) {
    throw responseJson["errorMessage"];
  } else {
    switch (response.statusCode) {
      case 200 || 201:
        return responseJson;
      default:
        throw FetchDataException(
          'Error while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
