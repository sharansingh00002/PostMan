import 'dart:convert';

import 'package:http/http.dart';
import 'package:postman/model/responseModel.dart';

class ApiProvider {
  Client client = Client();
  Response response;
  String responseStatusCode;
  String body;
  makeRequest({
    String requestType,
    String url,
    Map<String, String> headers,
  }) async {
    switch (requestType) {
      case 'GET':
        response = await client.get(
          url,
          headers: headers,
        );

        JsonEncoder encoder = JsonEncoder.withIndent('  ');
        body = encoder.convert(json.decode(response.body));

        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'POST':
        client.post(
          url,
          headers: headers,
        );
        responseStatusCode = response.statusCode.toString();
        body = response.body;
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'DELETE':
        client.delete(
          url,
          headers: headers,
        );
        responseStatusCode = response.statusCode.toString();
        body = response.body;
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PATCH':
        client.patch(
          url,
          headers: headers,
        );
        responseStatusCode = response.statusCode.toString();
        body = response.body;
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'PUT':
        client.put(
          url,
          headers: headers,
        );
        responseStatusCode = response.statusCode.toString();
        body = response.body;
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
      case 'READ':
        client.read(
          url,
          headers: headers,
        );
        responseStatusCode = response.statusCode.toString();
        body = response.body;
        return ResponseModel(
          responseCode: responseStatusCode,
          body: body,
        );
        break;
    }
  }
}
