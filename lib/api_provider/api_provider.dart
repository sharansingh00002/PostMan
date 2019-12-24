import 'dart:convert';

import 'package:http/http.dart';
import 'package:postman/model/responseModel.dart';

class ApiProvider {
  Client client = Client();
  Response response;
  String responseStatusCode = '';
  String body = '';
  makeRequest({
    String requestType,
    String url,
    Map<String, String> headers,
  }) async {
    switch (requestType) {
      case 'GET':
        try {
          response = await client.get(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'POST':
        try {
          client.post(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'DELETE':
        try {
          client.delete(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PATCH':
        try {
          client.patch(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PUT':
        try {
          client.put(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'READ':
        try {
          client.read(
            url,
            headers: headers,
          );
          responseStatusCode = response.statusCode.toString();
          var object = json.decode(response.body);
          body = JsonEncoder.withIndent('  ').convert(object);
        } catch (e) {
          body = response.body;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
    }
  }
}
