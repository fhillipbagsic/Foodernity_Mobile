import 'package:dio/dio.dart';
import 'package:foodernity_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FAQGuidelineService {
  Dio dio = new Dio();

  getFAQs() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return await dio.post(URL + 'getquestions',
          data: {'token': prefs.getString('emailAddress')});
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getGuidelines() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return await dio.post(URL + 'getguidelines',
          data: {'token': prefs.getString('emailAddress')});
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
