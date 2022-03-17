import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:foodernity_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Dio dio = new Dio();

  getAccount() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await dio.post(URL + 'getaccount',
          data: {'token': prefs.getString('emailAddress')},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  saveAccount(String profilePicture, String fullName, String password,
      bool hidden) async {
    final prefs = await SharedPreferences.getInstance();

    Future<String> getProfilePicture(String profilePicture) async {
      if (profilePicture.startsWith('https')) {
        return profilePicture;
      }
      final cloudinary =
          CloudinaryPublic('desimscj8', 'oqozctfv', cache: false);

      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(profilePicture,
              resourceType: CloudinaryResourceType.Image));

      return response.secureUrl;
    }

    try {
      return await dio.post(URL + 'saveaccount',
          data: {
            'profilePicture': await getProfilePicture(profilePicture),
            'fullName': fullName,
            'password': password,
            'hidden': hidden,
            'token': prefs.getString(('emailAddress'))
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await dio.post(URL + 'getnotifications',
          data: {
            'token': prefs.getString('emailAddress'),
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
