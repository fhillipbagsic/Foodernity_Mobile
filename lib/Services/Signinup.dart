import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:foodernity_mobile/main.dart';

class SignupService {
  Dio dio = Dio();

  signup(String fullName, String emailAddress, String password) async {
    try {
      return await dio.post(URL + 'signup',
          data: {
            'fullName': fullName,
            'emailAddress': emailAddress,
            'password': password
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
