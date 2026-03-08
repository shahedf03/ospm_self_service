import 'package:http/http.dart' as http;
import '../../helper/end_points.dart';
import 'base/api_base_helper.dart';

class ServiceModel<T> {
  // final List<Map<String, dynamic>> maps =
  //       await db.query("CUSTOMERS", where: "(ID =? ) AND (IMAGE =? )", whereArgs: [1, 5]);
  //Server api's
  Future<List<T>> handleGetData<T>({
    required String params,
    required T Function(Map<String, dynamic>) fromJson,
    int timeout = 10,
  }) {
    return ApiBaseHelper().get(
      params,
      fromJson,
      headers: {
        'accept': 'application/json',
        'Authorization': 'bearer ${box.read('token')}',
      },
      timeout: timeout,
    );
  }

  Future handlePostData(
      {required Object obj,
        required Function(Map<String, dynamic> json) json,
        int timeout = 150,
        String rest = ""}) {
    try {
      var response = ApiBaseHelper().post(rest, obj, json,
          headers: {
            'accept': '*/*',
            'Content-Type': 'application/json'
          },
          timeOut: timeout);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future handlePostMultipartFile({
    required String filePath,
    required String op,
    required String params,
  }) async {
    try {
      String url = '${baseUrl()}?op=$op$params';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'image',
        filePath,
      );
      request.files.add(multipartFile);

      http.StreamedResponse response = await request.send();

      var responeJson = await response.stream.bytesToString();
      return responeJson;
    } catch (e) {
      rethrow;
    }
  }

  String stringNullableJson(
    Map<String, dynamic> json,
    String key, {
    String value = "",
  }) {
    return json[key] == null ? value : json[key].toString();
  }

  int intNullableJson(Map<String, dynamic> json, String key) {
    return int.parse(json[key] == null ? "0" : json[key].toString());
  }

  double doubleNullableJson(Map<String, dynamic> json, String key) {
    return double.parse(json[key] == null ? "0.0" : json[key].toString());
  }
  bool boolNullableJson(Map<String, dynamic> json, String key) {
    return json[key] ?? false;
  }}
