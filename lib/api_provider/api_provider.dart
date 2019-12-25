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
    print('urlis $url');
    switch (requestType) {
      case 'GET':
        try {
          response = await client.get(
            url,
            headers: headers,
          );
          try {
            responseStatusCode = response.statusCode.toString();
            var object = json.decode(response.body);
            body = JsonEncoder.withIndent('  ').convert(object);
          } catch (e) {
            responseStatusCode = response.statusCode.toString();
            body = response.body;
          }
        } catch (e) {
          return null;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'POST':
        try {
          response = await client.post(
            url,
            headers: headers,
          );
          try {
            responseStatusCode = response.statusCode.toString();
            var object = json.decode(response.body);
            body = JsonEncoder.withIndent('  ').convert(object);
          } catch (e) {
            responseStatusCode = response.statusCode.toString();
            body = response.body;
          }
        } catch (e) {
          return null;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'DELETE':
        try {
          response = await client.delete(
            url,
            headers: headers,
          );
          try {
            responseStatusCode = response.statusCode.toString();
            var object = json.decode(response.body);
            body = JsonEncoder.withIndent('  ').convert(object);
          } catch (e) {
            responseStatusCode = response.statusCode.toString();
            body = response.body;
          }
        } catch (e) {
          return null;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PATCH':
        try {
          response = await client.patch(
            url,
            headers: headers,
          );
          try {
            responseStatusCode = response.statusCode.toString();
            var object = json.decode(response.body);
            body = JsonEncoder.withIndent('  ').convert(object);
          } catch (e) {
            responseStatusCode = response.statusCode.toString();
            body = response.body;
          }
        } catch (e) {
          return null;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PUT':
        try {
          response = await client.put(
            url,
            headers: headers,
          );
          try {
            responseStatusCode = response.statusCode.toString();
            var object = json.decode(response.body);
            body = JsonEncoder.withIndent('  ').convert(object);
          } catch (e) {
            responseStatusCode = response.statusCode.toString();
            body = response.body;
          }
        } catch (e) {
          return null;
        }
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
    }
  }
}
