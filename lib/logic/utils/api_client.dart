import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ApiClient extends http.BaseClient {
  final http.Client _httpClient = http.Client();

  ApiClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var token = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    Map defaultHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    request.headers.addAll({...defaultHeaders});
    return _httpClient.send(request);
  }
}
