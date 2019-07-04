import 'package:postman/api_calls/api_provider.dart';
import 'package:postman/model/responseModel.dart';
import 'package:postman/resources/values.dart';
import 'package:postman/ui/home_page.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();
  Future<void> makeRequest({
    String requestType,
    String url,
    Map<String, String> headers,
  }) async {
    ResponseModel responseModel = await _apiProvider.makeRequest(
      requestType: requestType,
      url: url,
      headers: headers,
    );
    print('recvd ${responseModel.responseCode}');
    mainResponseModel = responseModel;
  }
}
