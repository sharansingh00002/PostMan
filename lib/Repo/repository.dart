import 'package:postman/api_provider/api_provider.dart';
import 'package:postman/model/responseModel.dart';
import 'package:postman/resources/global.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();
  Future<bool> makeRequest({
    String requestType,
    String url,
    Map<String, String> headers,
  }) async {
    ResponseModel responseModel = await _apiProvider.makeRequest(
      requestType: requestType,
      url: url,
      headers: headers,
    );

    if (responseModel != null) {
//    print('responseis ${responseModel.s}');

      globalResponseStream.sink.add(responseModel);
      return true;
    } else {
      return null;
    }
  }
}
