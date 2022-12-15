
import 'api_helper.dart';

class ApiServices extends ApiHelper {
  static ApiServices? _apiServices;
  int? statusCode;

  factory ApiServices() {
    _apiServices ??= ApiServices._internal();
    return _apiServices!;
  }
  ApiServices._internal();

// login with Email And Password
//   Future<LoginResponse> emailLogin({required EmailLoginRequest request}) async {
//     try {
//       Response response = await ApiHelper.postEncodeCall(
//           path: ApiEndPoints.emailLogin, parameters: request.toJson());
//       var data = jsonDecode(response.body);
//       debugPrint("successful");
//       return LoginResponse?.fromJson(data, response.statusCode);
//     } catch (e) {
//       debugPrint("catch $e");
//       return Future.error(e);
//     }
//   }
}
