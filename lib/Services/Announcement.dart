import 'package:dio/dio.dart';
import 'package:foodernity_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnnouncementService {
  Dio dio = new Dio();

  getAnnouncements() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await dio.post(URL + 'getannouncements',
          data: {'token': prefs.getString('emailAddress')},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }
}
