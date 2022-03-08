import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:foodernity_mobile/main.dart';

class SignupService {
  Dio dio = Dio();

  signup(String fullName, String emailAddress, String password,
      String method) async {
    try {
      return await dio.post(URL + 'signup',
          data: {
            'fullName': fullName,
            'emailAddress': emailAddress,
            'password': password,
            'profilePicture':
                'https://res.cloudinary.com/desimscj8/image/upload/v1646642678/blank-profile-picture-g380f44ef1_1280_z6ofn0.png',
            'method': method,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  signin(String emailAddress, String password) async {
    try {
      return await dio.post(URL + 'signin',
          data: {
            'emailAddress': emailAddress,
            'password': password,
            'loginType': 'user'
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  forgotpassword(String emailAddress) async {
    try {
      return await dio.post(URL + 'forgotpassword',
          data: {'emailAddress': emailAddress},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  confirmCode(String emailAddress, String code) async {
    try {
      return await dio.post(URL + 'confirmcode',
          data: {'emailAddress': emailAddress, 'code': code},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  resetPassword(String emailAddress, String password) async {
    try {
      return await dio.post(URL + 'resetpassword',
          data: {'emailAddress': emailAddress, 'password': password},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
